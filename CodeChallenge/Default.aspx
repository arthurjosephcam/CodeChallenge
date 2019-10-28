<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CodeChallenge._Default" %>



<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- please see my comments on the code. Thanks! Arthur Cam. -->

    <div class="top-banner text-lg text-center" style="vertical-align: central">
        <label id="lblBanner">LOGIN</label>
    </div>

    <!-- I could add a bootstrap wizard here but I could not find a good one -->

    <!-- I also can add responsiveness by using bootstrap col-md-4 style but it is not necessary for this form -->
    <div class="container-div" id="contentLogin">
        <form id="loginForm">
            <div class="form-group">
                <div class="input-group">

                    <label for="logPwd" id="lblLogPwd" class="input-group">Password</label>
                    <input class="form-control" type="password" name="Password" id="logPwd" placeholder="Password" />

                </div>
            </div>
            <div class="form-group">
                <input title="Login" value="Login" id="btnLogin" class="btn btn-info form-control" type="button" onclick="GetLogin()" onsubmit="false" />
            </div>
        </form>

    </div>

    <div id="contentRegister" hidden="hidden">

        <form id="registerForm">
            <div class="form-group">
                <div class="input-group">

                    <label for="regName" id="lblRegName" class="input-group">First Name: *</label>
                    <input class="form-control" type="text" name="FirstName" id="regName" />

                </div>
            </div>
            <div class="form-group">
                <div class="input-group">

                    <label for="regLastName" id="lblRegLastName" class="input-group">Last Name: *</label>
                    <input class="form-control" type="text" name="LastName" id="regLastName" />

                </div>
            </div>

            <div class="form-group">
                <div class="input-group">
                    <label for="regStates" id="lblRegStates" class="input-group">State: *</label>
                    <select class="form-control" name="State" id="regStates"></select>

                </div>
            </div>


            <div>
                <p>
                    Please provide your email address.
                   <br />
                    All meetings correspondence will be sent via email.
                </p>
            </div>
            <div class="form-group">
                <div class="input-group">

                    <label for="regEmail" id="lblRegEmail" class="input-group">Email: *</label>
                    <input class="form-control" type="email" name="Email" id="regEmail" />

                </div>
            </div>
            <div class="form-group">
                <div class="input-group">

                    <label for="regEmail2" id="lblRegEmail2" class="input-group">Confirm Email</label>
                    <input class="form-control" type="email" name="Email2" id="regEmail2" />

                </div>
            </div>
            <div class="form-group">
                <div class="input-group">
                    <input type="checkbox" name="SubscribeToLetter" id="regSubscribe" />
                    Subscribe to newsletter.
                    
                </div>
            </div>




            <div class="form-group">
                <input title="Continue" value="Continue" class="btn btn-info form-control" type="button" onclick="RegisterNew()" onsubmit="false" />
            </div>
        </form>
    </div>

    <div id="contentThankYou" hidden="hidden">
        <div>
            <h3>Thank you for registering!</h3>
            <p>
                You should receive a confirmation email momentarily, containing additional details.
            </p>
        </div>
    </div>
    <script>

        //I normally use jquery validator but this is not directly fitting your requirements.
        //decided to move on with manual validation. but left a sample here to show how to use jquery validate.

        //also, generally I do not keep script in the html code, write into a .js file and include. To keep it easy, I left it here.

        //$(document).ready(function ()
        //{
        //    $("#loginForm").validate({
        //        rules: {
        //           logPwd:
        //            {
        //                required: true,
        //                minlength: 5

        //            },
        //        },
        //        messages:
        //        {
        //            Password: "*",
        //        },
        //    });
        //});

        var states = [
            { "Id": 0, "State": "Select State" },
            { "Id": 1, "State": "NJ" },
            { "Id": 2, "State": "PA" },
            { "Id": 3, "State": "MI" },
            { "Id": 4, "State": "CA" },
            { "Id": 5, "State": "VA" },
            { "Id": 6, "State": "WA" }
        ];

        $(document).ready(function ()
        {
            //Normally we can read it from an endpoint and database, 
            //but for now I manually created an object. Just to simulate.

            for (var i = 0; i <= states.length - 1; i++)
            {
                $('#regStates').append('<option value="' + states[i].Id + '">' + states[i].State + '</option>');
            }

        });




        function GetLogin()
        {
            var pwd = $("#logPwd").val();

            if (pwd == '')
            {
                $("#logPwd").addClass("field-required");
                $("#lblLogPwd").addClass("text-danger");
                return false;
            }


            var data = $("#logPwd").serialize();
            $.ajax({
                type: "post",
                data: data,
                url: "/Login/CheckLogin",
                success: function (result)
                {
                    if (result === "False")
                    {
                        alert("login unsuccessfull");
                        $("#logPwd").val("");
                        return false;

                    }
                    $("#contentLogin").hide();
                    $("#contentRegister").addClass("container-div");
                    $("#lblBanner").text("Contact Information");

                }

            });


        }


        function RegisterNew()
        {
            var validate = validateForm();

            if (!validate)
                return false;

            var data = $("#registerForm").serialize();
            $.ajax({
                type: "post",
                data: data,
                url: "/Register/RegisterNew",
                success: function (result)
                {
                    if (result === "False")
                    {
                        alert("Register unsuccessfull");
                        return false;

                    }

                    $("#contentRegister").hide();
                    $("#lblBanner").text("Complete");
                    $("#contentThankYou").addClass("container-div");

                }

            });


        }

        function validateForm()
        {
            var ret = true;


            var regName = $("#regName").val();
            var regLastName = $("#regLastName").val();
            var regStates = $("#regStates").val();
            var regEmail = $("#regEmail").val();
            var regEmail2 = $("#regEmail2").val();

            if (regName == '')
            {

                $("#regName").addClass("field-required");
                $("#lblRegName").addClass("text-danger");
                ret = ret && false;
            }
            else
            {
                $("#regName").removeClass("field-required");
                $("#lblRegName").removeClass("text-danger");
                ret = ret && true;
            }
            if (regLastName == '')
            {

                $("#regLastName").addClass("field-required");
                $("#lblRegLastName").addClass("text-danger");
                ret = ret && false;
            }
            else
            {
                $("#regLastName").removeClass("field-required");
                $("#lblRegLastName").removeClass("text-danger");
                ret = ret && true;
            }
            if (regStates == 0)
            {

                $("#regStates").addClass("field-required");
                $("#lblRegStates").addClass("text-danger");
                ret = ret && false;
            }
            else
            {
                $("#regStates").removeClass("field-required");
                $("#lblRegStates").removeClass("text-danger");
                ret = ret && true;
            }
            if (!validateEmail(regEmail))
            {

                $("#regEmail").addClass("field-required");
                $("#lblRegEmail").addClass("text-danger");
                ret = ret && false;
            }
            else
            {
                $("#regEmail").removeClass("field-required");
                $("#lblRegEmail").removeClass("text-danger");
                ret = ret && true;
            }
            if ((regEmail2 == '') || (regEmail.toLowerCase() != regEmail2.toLowerCase()))
            {

                $("#regEmail2").addClass("field-required");
                $("#lblRegEmail2").addClass("text-danger");
                ret = ret && false;
            }
            else
            {
                $("#regEmail2").removeClass("field-required");
                $("#lblRegEmail2").removeClass("text-danger");
                ret = ret && true;
            }
            return ret;
        }


        function validateEmail(email)
        {
            if (email == '') return false;
            var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            return re.test(String(email).toLowerCase());
        }
    </script>

</asp:Content>
