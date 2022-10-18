<%@ WebHandler Language="C#" Class="X" %>

using System;
using System.Web;
using System.Web.SessionState;

public class X : IHttpHandler,IRequiresSessionState {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        SysResult r = new SysResult();
        int code = GetCode(context);
        DataEntity entity = new DataEntity();
        entity.Values = context.Request.Form;

        r=Excute(code,entity);
        string json = JSONHelper.ToJSON(r);
        context.Response.Write(json);
        context.Response.End();

    }

    public bool IsReusable {
        get {
            return false;
        }
    }

    protected SysResult Excute(int code,DataEntity entity) {
        SysResult r = new SysResult();
        string storeid = "";
        string storename = "";
        string empno = "";
        string empname = "";
        string ass = "";
        string name = "";
        string phone = "";
        string cpt = "";
        string acName = "";
        string departid = "";
        string accessToken = "";
        string codenew = "";
        string storeId = "";
        string appid = "";
        string appsecret = "";
        SqlHelper.ConnectionServer = SqlHelper.getcnParms(System.AppDomain.CurrentDomain.BaseDirectory + "001.xml","ConnectionServer");
        SqlHelper.ConnectionServer = SqlHelper.ConnectionServer + SqlHelper.getcnParms(System.AppDomain.CurrentDomain.BaseDirectory + "001.xml","ConnectionStr");
        switch (code) {
            case 1000:
                storeid = entity.Values["storeid"] == null ? "" : entity.Values["storeid"];
                storename = entity.Values["storename"] == null ? "" : entity.Values["storename"];
                empno = entity.Values["empno"] == null ? "" : entity.Values["empno"];
                empname = entity.Values["empname"] == null ? "" : entity.Values["empname"];
                ass = entity.Values["ass"] == null ? "" : entity.Values["ass"];
                name = entity.Values["name"] == null ? "" : entity.Values["name"];
                phone = entity.Values["phone"] == null ? "" : entity.Values["phone"];
                r = Member.SetNxtRegister(storeid,storename,empno,empname,ass,name,phone);
                break;
            case 1001:
                cpt = entity.Values["cpt"] == null ? "" : entity.Values["cpt"];
                ass = entity.Values["ass"] == null ? "" : entity.Values["ass"];
                r = Member.GetNXTVoucher(cpt,ass);
                break;
            case 1002:
                cpt = entity.Values["cpt"] == null ? "" : entity.Values["cpt"];
                string param = entity.Values["param"] == null ? "" : entity.Values["param"];
                r = Member.GetStorreORemp(cpt,param);
                break;
            case 1003:
                storeid = entity.Values["storeid"] == null ? "" : entity.Values["storeid"];
                storename = entity.Values["storename"] == null ? "" : entity.Values["storename"];
                empno = entity.Values["empno"] == null ? "" : entity.Values["empno"];
                empname = entity.Values["empname"] == null ? "" : entity.Values["empname"];
                ass = entity.Values["ass"] == null ? "" : entity.Values["ass"];
                name = entity.Values["name"] == null ? "" : entity.Values["name"];
                phone = entity.Values["phone"] == null ? "" : entity.Values["phone"];
                r = Member.SetLDSRegister(storeid,storename,empno,empname,ass,name,phone);
                break;
            case 1004:
                cpt = entity.Values["cpt"] == null ? "" : entity.Values["cpt"];
                ass = entity.Values["ass"] == null ? "" : entity.Values["ass"];
                r = Member.GetLDSVoucher(cpt,ass);
                break;
            /**修改后的代码 1002公用*/
            case 1005:
                string memberCard = entity.Values["memberCard"] == null ? "" :entity.Values["memberCard"];
                string cate = entity.Values["acte"] == null ? "" :entity.Values["acte"];
                r = Member.GetHomePager(memberCard,cate);
                //r.Message = SqlHelper.ConnectionStr;
                break;
            case 1006:
                acName = entity.Values["acName"] == null ? "" : entity.Values["acName"];
                r = Member.GetProgramme(acName);
                break;
            case 1007:
                acName = entity.Values["acName"] == null ? "" : entity.Values["acName"];
                r = Member.GetProductInfo(acName);
                break;
            case 1008:
                storeid = entity.Values["storeid"] == null ? "" : entity.Values["storeid"];
                storename = entity.Values["storename"] == null ? "" : entity.Values["storename"];
                empno = entity.Values["empno"] == null ? "" : entity.Values["empno"];
                empname = entity.Values["empname"] == null ? "" : entity.Values["empname"];
                ass = entity.Values["ass"] == null ? "" : entity.Values["ass"];
                name = entity.Values["name"] == null ? "" : entity.Values["name"];
                phone = entity.Values["phone"] == null ? "" : entity.Values["phone"];
                acName = entity.Values["acName"] == null ? "" : entity.Values["acName"];
                r = Member.SetDrugRegister(storeid,storename,empno,empname,ass,name,phone,acName);
                break;
            case 1009:
                cpt = entity.Values["cpt"] == null ? "" : entity.Values["cpt"];
                ass = entity.Values["ass"] == null ? "" : entity.Values["ass"];
                acName = entity.Values["acName"] == null ? "" : entity.Values["acName"];
                r = Member.GetDrugVoucher(cpt,ass,acName);
                break;
            case 1010:
                r = Member.GetDrugCategory();
                break;
            case 1020:
                departid = entity.Values["departid"] == null ? "" : entity.Values["departid"];
                r = Member.GetSapShop(departid);
                break;
            case 1021:
                accessToken = entity.Values["accessToken"] == null ? "" : entity.Values["accessToken"];
                codenew = entity.Values["code"] == null ? "" : entity.Values["code"];
                r = Member.GetTel(accessToken,codenew);
                break;
            case 1022:
                phone = entity.Values["phone"] == null ? "" : entity.Values["phone"];
                storeId = entity.Values["storeId"] == null ? "" : entity.Values["storeId"];
                //r = Member.GetMemberInfo(phone,storeId);
                break;
            case 1023:
                appid = entity.Values["appid"] == null ? "" : entity.Values["appid"];
                appsecret = entity.Values["appsecret"] == null ? "" : entity.Values["appsecret"];
                codenew = entity.Values["code"] == null ? "" : entity.Values["code"];
                r = Member.GetTel(appid,appsecret,codenew);
                break;
        }
        return r;

    }

    public int GetCode(HttpContext context)
    {
        int c;
        int t;
        c = string.IsNullOrWhiteSpace(context.Request.Form["c"]) ? -1 : int.TryParse(context.Request.Form["c"], out t) ? t : -1;
        return c;
    }

}