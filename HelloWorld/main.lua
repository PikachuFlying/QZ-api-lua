require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.widget.ScrollView"
import "android.widget.LinearLayout"
import "android.widget.TextView"
import "com.androlua.Http"
import "http"
import "android.R"
import "layout"

activity.setTitle("api登录")
activity.setContentView(loadlayout(layout))

tokens={}
学号="2017412xxx"
密码="xxxxxxx"
教务地址="http://zhjw.qfnu.edu.cn/"

--本代码由曲师大刘玉强整理发布，如有借鉴请声明

function 登录(xh,mm,dz)
  Http.get(dz.."app.do?method=authUser&xh="..xh.."&pwd="..mm,nil,"UTF-8",nil,function(code,body,cookie,header)
    if(code==200)then--1
      cjson = require "cjson"
      data = cjson.decode(body);
      xsw.Text=data["token"]
      table.insert(tokens,data["token"])
      print("登录成功")
     else
      xsw.Text="连接失败"
    end
  end)
end

function 时间信息(sj)
  hdr={["token"] = tokens[1],}
  Http.get(教务地址.."app.do?method=getCurrentTime&currDate="..sj,cookie,"UTF-8",hdr,function(code,body,cookie,header)    
    --table.insert(tokens,body)
    xsw.Text=body
    print(body)
  end)
end

function 课程信息(xh,xq,zc)
  hdr={["token"] = tokens[1],}
  Http.get(教务地址.."app.do?method=getKbcxAzc&xh="..xh.."&xnxqid="..xq.."&zc="..zc,cookie,"UTF-8",hdr,function(code,body,cookie,header)    
    --table.insert(tokens,body)
     xsw.Text=body
    print(body)
  end)
  end

function 成绩信息(xh,xq)
  hdr={["token"] = tokens[1],}
  Http.get(教务地址.."app.do?method=getCjcx&xh="..xh.."&xnxqid="..xq,cookie,"UTF-8",hdr,function(code,body,cookie,header)    
    --table.insert(tokens,body)
    xsw.Text=body
    print(body)
  end)
  end

function 考试信息(xh)
  hdr={["token"] = tokens[1],}
  Http.get(教务地址.."app.do?method=getKscx&xh="..xh,cookie,"UTF-8",hdr,function(code,body,cookie,header)    
    --table.insert(tokens,body)
    xsw.Text=body
    print(body)
  end)
  end

function 学籍预警信息(xh,ls)
  hdr={["token"] = tokens[1],}
  Http.get(教务地址.."app.do?method=getEarlyWarnInfo&xh="..xh.."&history="..ls,cookie,"UTF-8",hdr,function(code,body,cookie,header)    
    --table.insert(tokens,body)
    xsw.Text=body
    print(body)
  end)
  end

function 教学楼信息(xq)
  hdr={["token"] = tokens[1],}
  Http.get(教务地址.."app.do?method=getJxlcx&xqid="..xq,cookie,"UTF-8",hdr,function(code,body,cookie,header)    
    --table.insert(tokens,body)
    xsw.Text=body
    print(body)
  end)
  end

function 空教室信息(rq,sjd,xq,jxlid,jsid)
  hdr={["token"] = tokens[1],}
  Http.get(教务地址.."app.do?method=getKxJscx&time="..rq.."&idleTime="..sjd.."&xqid="..xq.."&jxlid="..jxlid.."&classroomNumber="..jsid,cookie,"UTF-8",hdr,function(code,body,cookie,header)    
    --table.insert(tokens,body)
    xsw.Text=body
    print(body)
  end)
  end

function 用户信息(xh)
  hdr={["token"] = tokens[1],}
  Http.get(教务地址.."app.do?method=getStudentIdInfo&xh="..xh,cookie,"UTF-8",hdr,function(code,body,cookie,header)    
    --table.insert(tokens,body)
    xsw.Text=body
    print(body)
  end)
  end

function 账号信息(xh)
  hdr={["token"] = tokens[1],}
  Http.get(教务地址.."app.do?method=getUserInfo&xh="..xh,cookie,"UTF-8",hdr,function(code,body,cookie,header)    
    --table.insert(tokens,body)
    xsw.Text=body
    print(body)
  end)
  end

function 学年学期信息(xh)
    hdr={["token"] = tokens[1],}
  Http.get(教务地址.."app.do?method=getXnxq&xh="..xh,cookie,"UTF-8",hdr,function(code,body,cookie,header)    
    --table.insert(tokens,body)
    xsw.Text=body
    print(body)
  end)
  end

function 校区信息()
    hdr={["token"] = tokens[1],}
  Http.get(教务地址.."app.do?method=getXqcx",cookie,"UTF-8",hdr,function(code,body,cookie,header)    
    --table.insert(tokens,body)
    xsw.Text=body
    print(body)
  end)
  end



an.onClick=function(v)
单选列表={}
  table.insert(单选列表,"登录(请先点击登录)")
  table.insert(单选列表,"时间信息")
  table.insert(单选列表,"课程信息")
  table.insert(单选列表,"成绩信息")
  table.insert(单选列表,"考试信息")
  table.insert(单选列表,"学籍预警信息")
  table.insert(单选列表,"教学楼信息")
  table.insert(单选列表,"空教室信息")
  table.insert(单选列表,"用户信息")
  table.insert(单选列表,"账号信息")
  table.insert(单选列表,"学年学期信息")
  table.insert(单选列表,"校区信息")
  
local 单选对话框=AlertDialog.Builder(this)
.setTitle("强智教务系统API")
.setSingleChoiceItems(单选列表,-1,{onClick=function(v,p)
    
    if p==0 then
      登录(学号,密码,教务地址)
      elseif p==1 then
      时间信息("2019-05-05")
      elseif p==2 then
      课程信息(学号,"2018-2019-2","10")
      elseif p==3 then
      成绩信息(学号,"2018-2019-1")
      elseif p==4 then
      考试信息(学号)
      elseif p==5 then
      学籍预警信息(学号,"1")
      elseif p==6 then
      教学楼信息("1")
      elseif p==7 then
      空教室信息("2019-05-08","allday","1","Q09","")
      elseif p==8 then
      用户信息(学号)
      elseif p==9 then
      账号信息(学号)
      elseif p==10 then
      学年学期信息(学号)
      else 
      校区信息()
      end
    
    end})
单选对话框.show();
end





