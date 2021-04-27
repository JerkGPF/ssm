<%--
  Created by IntelliJ IDEA.
  User: gpfei
  Date: 2021/4/26
  Time: 21:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <!--web路径
    不以/开始的相对路径，找资源，已当前资源的路径为基准
    以/开始的相对路径，找资源以服务器的路径为标准http://localhost:8080;需要加上项目名
    localhost:8080/ssm-->
    <%--    引入jquery--%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
    <%--  引样式  --%>
    <link href="${APP_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
</head>
<body>
    <!-- 员工修改模态框 -->
    <div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">员工修改</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <p class="form-control-static" id="empName_update_static"></p>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@qq.com">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">deptName</label>
                            <div class="col-sm-4">
                                <!--部门提交id即可-->
                                <select class="form-control" name="dId" id="dept_update_select">

                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
                </div>
            </div>
        </div>
    </div>
    <!-- 员工新增模态框 -->
    <div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">员工新增</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@qq.com">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">deptName</label>
                            <div class="col-sm-4">
                                <!--部门提交id即可-->
                                <select class="form-control" name="dId" id="dept_add_select">

                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
                </div>
            </div>
        </div>
    </div>
    <!--搭建页面-->
    <div class="container">
        <!--标题-->
        <div class="row">
            <div class="col-md-12">
                <h1>SSM-CRUD</h1>
            </div>
        </div>
        <!--按钮-->
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button class="btn btn-primary" id="emp_add_model_btn">新增</button>
                <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
            </div>
        </div>
        <!--显示表格数据信息-->
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover" id="emps_table">
                    <thead>
                        <tr>
                            <th>
                                <input type="checkbox" id="check_all">
                            </th>
                            <th>#</th>
                            <th>empName</th>
                            <th>gender</th>
                            <th>email</th>
                            <th>deptName</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>

                    </tbody>


                </table>
            </div>
        </div>
        <!--显示分页信息-->
        <div class="row" >
            <!--分页文字信息-->
            <div class="col-md-6" id="page_info_area">

            </div>
            <!--分页条信息-->
            <div class="col-md-6" id="page_nav_area">

            </div>
        </div>
    </div>
    <script type="text/javascript">
        var totalRecord,currentPage;
        //1.页面加载完成后，发送Ajax请求，拿到分页数据
        $(function (){
            //去首页
            to_page(1);
        });
        function to_page(pn){
            $.ajax({
                url:"${APP_PATH}/emps",
                data:"pn="+pn,
                type:"get",
                success:function (result){
                    //console.log(result);
                    //1.解析并显示员工数据
                    build_emps_table(result);
                    //2.解析并显示分页信息
                    build_page_info(result);
                    //3.解析显示分页条
                    build_page_nav(result);

                }
            });
        }
        function build_emps_table(result){
            //清空表格数据
            $("#emps_table tbody").empty();
            var emps = result.extend.pageInfo.list;
            $.each(emps,function (index,item) {
                var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
                var empIdTd = $("<td></td>").append(item.empId);
                var empNameTd = $("<td></td>").append(item.empName);
                var gender = item.gender=='M'?"男":"女";
                var genderTd = $("<td></td>").append(gender);
                var emailTd = $("<td></td>").append(item.email);
                var deptNameTd = $("<td></td>").append(item.department.deptName);
                var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
                editBtn.attr("edit-id",item.empId);
                var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
                delBtn.attr("del-id",item.empId);

                var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
                //append方法执行后返回还是原来的元素
                $("<tr></tr>").append(checkBoxTd)
                    .append(empIdTd)
                    .append(empNameTd)
                    .append(genderTd)
                    .append(emailTd)
                    .append(deptNameTd)
                    .append(btnTd)
                    .appendTo("#emps_table tbody");

            });
        }
        //解析显示分页信息
        function build_page_info(result){
            $("#page_info_area").empty();
            $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页,总"
                +result.extend.pageInfo.pages+"页,总"
                +result.extend.pageInfo.total+"条记录");
            totalRecord = result.extend.pageInfo.total;
            currentPage = result.extend.pageInfo.pageNum;
        }
        //解析显示分页条
        function build_page_nav(result) {
            $("#page_nav_area").empty();
            var ul =$("<ul></ul>").addClass("pagination");
            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            var perPageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
            if (result.extend.pageInfo.hasPreviousPage==false){
                firstPageLi.addClass("disabled");
                perPageLi.addClass("disabled");
            }else {
                firstPageLi.click(function (){//首页
                    to_page(1);
                });
                perPageLi.click(function (){//前一页
                    to_page(result.extend.pageInfo.pageNum-1)
                });
            }

            var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
            var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
            if (result.extend.pageInfo.hasNextPage==false){
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else {
                nextPageLi.click(function (){
                    to_page(result.extend.pageInfo.pageNum+1)
                });
                lastPageLi.click(function (){
                    to_page(result.extend.pageInfo.pages);
                });
            }

            ul.append(firstPageLi).append(perPageLi);
            $.each(result.extend.pageInfo.navigatepageNums,function (index,item){
                var numLi = $("<li></li>").append($("<a></a>").append(item));
                if (result.extend.pageInfo.pageNum==item){
                    numLi.addClass("active");
                }
                numLi.click(function (){
                   to_page(item);
                });
                ul.append(numLi);
            });
            ul.append(nextPageLi).append(lastPageLi);
            var navEle = $("<nav></nav>").append(ul);
            navEle.appendTo("#page_nav_area");
        }
        // 清除表单信息
        function reset_form(ele){
            $(ele)[0].reset();
            //清空表单样式
            $(ele).find("*").removeClass("has-error has-success");
            $(ele).find(".help-block").text("");
        }
        //弹出模态框
        $("#emp_add_model_btn").click(function () {
            //清除表单信息
            reset_form("#empAddModal form");
            //发送ajax请求，查出部门信息，并显示在下拉列表中
            getDeps("#dept_add_select");
            //弹出模态框
            $("#empAddModal").modal({
                backdrop:"static"
            });
        });
        //查询出所有的部门信息
        function getDeps(ele) {
            //清空下拉列表的值
            $(ele).empty();
            $.ajax({
                url: "${APP_PATH}/depts",
                type: "GET",
                success:function (result){
                    //console.log(result);
                    //显示部门信息至下拉列表
                    $.each(result.extend.depts,function (){
                        var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                        optionEle.appendTo(ele);
                    });
                }
            });
        }
        //校验表单信息
        function validate_add_form(){
            //拿到校验数据，使用正则校验
            var empName = $("#empName_add_input").val();
            var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
            if (!regName.test(empName)){
                //alert("用户名可以是2-5位中文，6-16位英文和数字组合");
                show_validate_msg("#empName_add_input","error","用户名可以是2-5位中文，6-16位英文和数字组合")
                return false;
            }else {
                show_validate_msg("#empName_add_input","success","")
            }
            //邮箱校验
            var email = $("#email_add_input").val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if (!regEmail.test(email)){
                //alert("邮箱格式不正确");
                show_validate_msg("#email_add_input","error","邮箱格式不正确");
                return false;
            }else {
                show_validate_msg("email_add_input","success","");
            }
            return true;
        }
        function show_validate_msg(ele,status,msg){
            //清除当前的状态
            $(ele).parent().removeClass("has-success has-error");
            $(ele).next("span").text("");
            if ("success"==status){
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text(msg);
            }else if ("error"==status){
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg);
            }
        }
        $("#empName_add_input").change(function () {
            //发送ajax请求，校验用户名是否可用
            var empName = this.value;
            $.ajax({
                url:"${APP_PATH}/checkUser",
                data:"empName="+empName,
                type:"POST",
                success:function (result) {
                    if (result.code==100){
                        show_validate_msg("#empName_add_input","success","用户名可用");
                        $("#emp_save_btn").attr("ajax-va","success");
                    }else {
                        show_validate_msg("#empName_add_input","error",result.extend.va_msg);
                        $("#emp_save_btn").attr("ajax-va","error");

                    }
                }
            })
        })
        $("#emp_save_btn").click(function () {
            //进行校验
            if (!validate_add_form()){
                return false;
            }
            //判断ajax的用户名校验是否成功
            if ($(this).attr("ajax-va")=="error"){
                return false;
            }
            //1.获取所有的信息,并保存到服务器
            //2.发送ajax请求
            $.ajax({
                url:"${APP_PATH}/emp",
                type:"POST",
                data: $("#empAddModal form").serialize(),
                success:function (result){
                    if (result.code==100){
                        //员工保存成功
                        //1.关闭模态框
                        $("#empAddModal").modal('hide');
                        //进行数据校验

                        //2.到最后一页，显示保存的数据
                        //发送ajax请求显示最后一页
                        to_page(totalRecord);
                    }else {
                        //显示失败信息
                        //console.log(result);
                        if (undefined != result.extend.errorFields.email){
                            //显示邮箱错误信息
                            show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
                        }
                        if (undefined != result.extend.errorFields.empName){
                            //显示name错误信息
                            show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
                        }
                    }

                }
            })
        });
        //绑定事件

        $(document).on("click",".edit_btn",function () {
            //查出部门信息
            getDeps("#empUpdateModal select")
            //查出员工信息并显示
            getEmp($(this).attr("edit-id"));
            //把员工id传递给模态框的更新按钮
            $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
            //弹出模态框
            $("#empUpdateModal").modal({
                backdrop:"static"
            });
        });
        function getEmp(id){
            $.ajax({
                url:"${APP_PATH}/emp/"+id,
                type:"GET",
                success:function (result) {
                    //console.log(result);
                    var empData = result.extend.emp;
                    $("#empName_update_static").text(empData.empName);
                    $("#email_update_input").val(empData.email);
                    $("#empUpdateModal input[name=gender]").val([empData.gender]);
                    $("#empUpdateModal select").val([empData.dId]);

                }

            });
        }
        //点击更新，更新员工信息
        $("#emp_update_btn").click(function(){
            //验证邮箱是否合法
            //1、校验邮箱信息
            var email = $("#email_update_input").val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if(!regEmail.test(email)){
                show_validate_msg("#email_update_input", "error", "邮箱格式不正确");
                return false;
            }else{
                show_validate_msg("#email_update_input", "success", "");
            }

            //2、发送ajax请求保存更新的员工数据
            $.ajax({
                url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
                type:"PUT",
                data:$("#empUpdateModal form").serialize(),
                success:function(result){
                    //alert(result.msg);
                    //1、关闭对话框
                    $("#empUpdateModal").modal("hide");
                    //回到当前页面
                    to_page(currentPage);
                }
            });
        });

        //单个删除
        $(document).on("click",".delete_btn",function () {
            //弹出确定对话框
            var empName =  $(this).parents("tr").find("td:eq(2)").text();
            var empId = $(this).attr("del-id");
           if(confirm("确认删除["+empName+"]吗？")){
               //确认发送ajax请求
               $.ajax({
                   url:"${APP_PATH}/emp/"+empId,
                   type:"DELETE",
                   success:function (result) {
                       alert(result.msg);
                       //回到本页
                       to_page(currentPage);
                   }
               })
           }
        });
        //全选和全不选功能
        $("#check_all").click(function () {
            //attr获取值是undefined
            //获取原生的数据用prop获取，attr自定义
            $(".check_item").prop("checked",$(this).prop("checked"));
            // check_item
            $(document).on("click",".check_item",function () {
                //判断当前选择的元素是否位5个
                var flag = $(".check_item:checked").length==$(".check_item").length;
                $("#check_all").prop("checked",flag);
            })
        });
        //点击全部删除，进行批量删除
        $("#emp_delete_all_btn").click(function () {
            var empNames = "";
            var del_idstr = "";
            $.each($(".check_item:checked"),function () {
                empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
                del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
            })
            //去除empNames多余的，
            empNames = empNames.substring(0,empNames.length-1);
            //去除多余-
            del_idstr = del_idstr.substring(0,del_idstr.length-1);
            if (confirm("确认删除【"+empNames+"】吗？")){
                //发送请求
                $.ajax({
                    url:"${APP_PATH}/emp/"+del_idstr,
                    type:"DELETE",
                    success:function (result) {
                        alert(result.msg);
                        //回到当前
                        to_page(currentPage);
                    }
                })
            }
        });
    </script>

</body>
</html>
