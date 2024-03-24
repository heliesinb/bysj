<template>
    <div>
        <el-calendar>
       
            <template slot="dateCell" slot-scope="{data}">
                <div style="min-height: 85px; word-break: break-all" >
                    <div>{{ data.day.split('-').slice(1).join('-') }} </div>
                    <div v-if="arr.find(v => v.date === data.day)" v-html="arr.find(v => v.date === data.day).content">
                    </div>
                </div>
            </template>
        </el-calendar>

        
        <el-dialog title="今天要做的事" :visible.sync="visible" width="20%">
            <div v-html="content" style="line-height: 30px; text-align: left; padding: 0 80px;"></div>
            <el-button @click="saveContent" style="margin-top: 20px; margin-left: 80px;" type="primary">我知道了</el-button>
        </el-dialog>
    </div>
</template>

<script>

export default {
 name:'lookCalendar',
    data() {
        return {
            value: new Date(),
            arr: [],
            dialogFormVisible: false,
            calendar: {},
            visible: false,
            content: '',
            date: ''
        }
    },
    created() {
        this.load();

    },
    methods: {
        saveContent() {
            this.visible = false;
            localStorage.setItem('calendarVisible', this.date);
        },
        load() {
            fetch("http://localhost:9000/calendar").then(res => res.json()).then(res => {
                this.arr = res;
                const dateStorage = localStorage.getItem('calendarVisible')
                const date = new Date().toJSON().split('T').join(' ').substr(0, 10); //今天
                const data = this.arr.find(v => v.date === date);//从数据库查出的对象
                if (!dateStorage || (data && dateStorage !== data.date)) {
                    this.content = data.content;
                    this.date = data.date;
                    this.visible = true;
                }
            })
        },

       
    }
}
</script>

<style>
.is-selected {
    color: #1989FA;
}

.el-calendar-table .el-calendar-day {
    height: auto !important;
    min-height: 85px;
    text-align: left;
}
</style>