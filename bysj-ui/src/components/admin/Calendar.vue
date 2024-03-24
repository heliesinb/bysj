<template>
    <div>
        <el-calendar>
            <!-- 这里使用的是 2.5 slot 语法，对于新项目请使用 2.6 slot 语法-->
            <template slot="dateCell" slot-scope="{data}">
                <div style="min-height: 85px; word-break: break-all" @click="handleClick(data.day)">
                    <div>{{ data.day.split('-').slice(1).join('-') }} </div>
                    <div v-if="arr.find(v => v.date === data.day)" v-html="arr.find(v => v.date === data.day).content">
                    </div>
                </div>
            </template>
        </el-calendar>

        <el-dialog title="日程安排" :visible.sync="dialogFormVisible">
            <el-form :model="calendar" ref="addFormRef">
                
                <el-form-item label="请填写日程内容" prop="content">
                    <el-input v-model="calendar.content" autocomplete="off" style="width:80%"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="cancel">取 消</el-button>
                <el-button type="primary" @click="save">确 定</el-button>
            </div>
        </el-dialog>

        <el-dialog title="今天要做的事" :visible.sync="visible" width="20%">
            <div v-html="content" style="line-height: 30px; text-align: left; padding: 0 80px;"></div>
            <el-button @click="saveContent" style="margin-top: 20px; margin-left: 80px;" type="primary">我知道了</el-button>
        </el-dialog>
    </div>
</template>

<script>

export default {
    name: 'calendar',
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

        handleClick(date) {
            // this.$refs.addFormRef.resetFields();
            
            fetch("http://localhost:9000/calendar/date?date=" + date).then(res => res.text()).then(res => {
                if (res) {
                    this.calendar = JSON.parse(res);
                }
                
                this.dialogFormVisible = true;


            })

        },
        cancel(){
            this.dialogFormVisible = false;
            this.calendar = {};
        },
        save() {
            var aData = new Date();    
            this.calendar.date= aData.getFullYear() + "-" + (aData.getMonth() + 1) + "-" + aData.getDate();     
            fetch("http://localhost:9000/calendar", {
                method: "post",
                headers: {
                    "Content-Type": "application/json;charset=utf-8",
                },
                body: JSON.stringify(this.calendar)
            }).then(res => {
                if (res.status === 200) {
                    
                    this.$message.success("设置日程成功");
                    this.load();
                    this.calendar = {};
                    this.dialogFormVisible = false;
                } else {
                    this.$message.error("设置日程失败");
                }
              
            })
        }
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