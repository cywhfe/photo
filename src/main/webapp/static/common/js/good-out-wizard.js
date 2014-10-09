var GoodOutWizard = function () {

    function initDataTable(){
        jQuery('#detailTable .group-checkable').change(function () {
        var set = jQuery(this).attr("data-set");
        var checked = jQuery(this).is(":checked");
        jQuery(set).each(function () {
            if (checked) {
                $(this).attr("checked", true);
            } else {
                $(this).attr("checked", false);
            }
        });
        jQuery.uniform.update(set);
         });

        jQuery('#detailTable_wrapper .dataTables_filter input').addClass("form-control input-large"); // modify table search input
        jQuery('#detailTable_wrapper .dataTables_length select').addClass("form-control input-xsmall"); // modify table per page dropdown
        jQuery('#detailTable_wrapper .dataTables_length select').select2(); // initialize select2 dropdown
    }

    return {
        //main function to initiate the module
        init: function () {
            if (!jQuery().bootstrapWizard) {
                return;
            }

            var form = $('#submit_form');
            var error = $('.alert-danger', form);
            var success = $('.alert-success', form);

            form.validate({
                doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
                errorElement: 'span', //default input error message container
                errorClass: 'help-block', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                rules: {
                    //account
                    username: {
                        minlength: 5,
                        required: true
                    }           
                },

                messages: { // custom messages for radio buttons and checkboxes
                    'payment[]': {
                        required: "Please select at least one option",
                        minlength: jQuery.format("Please select at least one option")
                    }
                },

                errorPlacement: function (error, element) { // render error placement for each input type
                    if (element.attr("name") == "gender") { // for uniform radio buttons, insert the after the given container
                        error.insertAfter("#form_gender_error");
                    } else if (element.attr("name") == "payment[]") { // for uniform radio buttons, insert the after the given container
                        error.insertAfter("#form_payment_error");
                    } else {
                        error.insertAfter(element); // for other inputs, just perform default behavior
                    }
                },

                invalidHandler: function (event, validator) { //display error alert on form submit   
                    success.hide();
                    error.show();
                    App.scrollTo(error, -200);
                },

                highlight: function (element) { // hightlight error inputs
                    $(element)
                        .closest('.form-group').removeClass('has-success').addClass('has-error'); // set error class to the control group
                },

                unhighlight: function (element) { // revert the change done by hightlight
                    $(element)
                        .closest('.form-group').removeClass('has-error'); // set error class to the control group
                },

                success: function (label) {
                    if (label.attr("for") == "gender" || label.attr("for") == "payment[]") { // for checkboxes and radio buttons, no need to show OK icon
                        label
                            .closest('.form-group').removeClass('has-error').addClass('has-success');
                        label.remove(); // remove error label here
                    } else { // display success icon for other inputs
                        label
                            .addClass('valid') // mark the current input as valid and display OK icon
                        .closest('.form-group').removeClass('has-error').addClass('has-success'); // set success class to the control group
                    }
                },

                submitHandler: function (form) {
                    success.show();
                    error.hide();
                    //add here some ajax code to submit your form or just call form.submit() if you want to submit the form without ajax
                }

            });

            var displayConfirm = function() {
                $('#tab3 .form-control-static', form).each(function(){
                    var input = $('[name="'+$(this).attr("data-display")+'"]', form);
                    if (input.is(":text") || input.is("textarea")) {
                        $(this).html(input.val());
                    } else if (input.is("select")) {
                        $(this).html(input.find('option:selected').text());
                    } else if (input.is(":radio") && input.is(":checked")) {
                        $(this).html(input.attr("data-title"));
                    } else if ($(this).attr("data-display") == 'payment') {
                        var payment = [];
                        $('[name="payment[]"]').each(function(){
                            payment.push($(this).attr('data-title'));
                        });
                        $(this).html(payment.join("<br>"));
                    } else if ($(this).attr("data-display") == "detailTable") {
                        var tableArray = ["<table class='table table-striped table-bordered table-hover'>", 
                        "<tr><td>货物名称</td><td>当前数量</td><td>入库数量</td><td>入库价格</td><td>单位</td><td>出库数量</td></tr>"];
                        $("#detailTable").find("input:checked").each(function(index, item){
                            tableArray.push("<tr>");
                            $(item).parent().siblings().each(function(i, itemTR){
                                if($(itemTR).has("input").length > 0){
                                    tableArray.push("<td class='center'>" + $("#"+$(this).find("div")[0].id).spinner("value") + "</td>");
                                }else{
                                    tableArray.push("<td class='center'>" + $(itemTR).text() + "</td>");
                                }
                            });
                            tableArray.push("</tr>");
                        });
                        tableArray.push("</table>");
                        $(this).html(tableArray.join(""));
                    };
                });
            }

            var handleTitle = function(tab, navigation, index) {
                var total = navigation.find('li').length;
                var current = index + 1;
                // set wizard title
                $('.step-title', $('#form_wizard_1')).text('Step ' + (index + 1) + ' of ' + total);
                // set done steps
                jQuery('li', $('#form_wizard_1')).removeClass("done");
                var li_list = navigation.find('li');
                for (var i = 0; i < index; i++) {
                    jQuery(li_list[i]).addClass("done");
                }

                if (current == 1) {
                    $('#form_wizard_1').find('.button-previous').hide();
                } else {
                    $('#form_wizard_1').find('.button-previous').show();
                }

                if (current >= total) {
                    $('#form_wizard_1').find('.button-next').hide();
                    $('#form_wizard_1').find('.button-submit').show();
                    displayConfirm();
                } else {
                    $('#form_wizard_1').find('.button-next').show();
                    $('#form_wizard_1').find('.button-submit').hide();
                }
                App.scrollTo($('.page-title'));
            }

            // default form wizard
            $('#form_wizard_1').bootstrapWizard({
                'nextSelector': '.button-next',
                'previousSelector': '.button-previous',
                onTabClick: function (tab, navigation, index, clickedIndex) {
                    success.hide();
                    error.hide();
                    if (form.valid() == false) {
                        return false;
                    }
                    handleTitle(tab, navigation, clickedIndex);
                },
                onNext: function (tab, navigation, index) {
                    success.hide();
                    error.hide();

                    if (form.valid() == false) {
                        return false;
                    }

                    handleTitle(tab, navigation, index);
                },
                onPrevious: function (tab, navigation, index) {
                    success.hide();
                    error.hide();

                    handleTitle(tab, navigation, index);
                },
                onTabShow: function (tab, navigation, index) {
                    var total = navigation.find('li').length;
                    var current = index + 1;
                    var $percent = (current / total) * 100;
                    $('#form_wizard_1').find('.progress-bar').css({
                        width: $percent + '%'
                    });
                }
            });

            $('#form_wizard_1').find('.button-previous').hide();
            $('#form_wizard_1 .button-submit').click(function () {
                $.post('../goodout/create', $("#submit_form").serialize(),function(data){
                    if (data === "true") {
                        window.location.href = "../goodout";
                    }else{
                        alert("网络异常，请重新添加");
                    };
                });
            }).hide();

            //add jquery datatable good out details
            var options={};
            var oTable=null;
            options.sAjaxSource="../goodoutdetail/list";
            options.bServerSide=false;
            options.aoColumns = [ { 
                "sTitle": "<input type='checkbox' id='selectAll' class='group-checkable' data-set='#detailTable .checkboxes'/>&nbsp;选择", 
                "sClass": "center" , 
                "sWidth":"50px",
                "fnRender" : function (obj) {
                    return '<input type="checkbox" name="details" class="checkboxes" value="'+obj.aData.in_id + "-" +obj.aData.goods_id +'" />';
                },
                "bSortable":false
            },{
                "sTitle" : "货物名称",
                "sClass" : "center",
                "mDataProp" : "goods_name"
            }, {
                "sTitle" : "当前数量",
                "sClass" : "center",
                "mDataProp" : "goods_quantity_now"
            }, {
                "sTitle" : "入库总数",
                "sClass" : "center",
                "mDataProp" : "goods_quantity"
            }, {
                "sTitle" : "入库总价",
                "sClass" : "center",
                "mDataProp" : "goods_amount"
            },{
                "sTitle" : "单位",
                "sClass" : "center",
                "mDataProp" : "goods_unit_name"
            }, {
                "sTitle": "出库数量", 
                "sClass": "center" , 
                "sWidth":"100px",
                "fnRender" : function (obj) {
                    return '<div id="'+obj.aData.in_id+"-"+obj.aData.goods_id+'spinnerDiv"><div class="input-group input-small"><input type="text" name="nums" class="spinner-input form-control digits" maxlength="3" ><div class="spinner-buttons input-group-btn btn-group-vertical"><button type="button" class="btn spinner-up btn-xs blue"><i class="fa fa-angle-up"></i></button><button type="button" class="btn spinner-down btn-xs blue"><i class="fa fa-angle-down"></i></button></div></div></div>';
                },
                "bSortable":false
                
            }];
            options.fnInitComplete = function(data){
                for(var i = 0; i < data.aoData.length; i++){
                    //spinner initial, max value is goods_quantity
                    $("#"+$(data.aoData[i]._aData[6]).attr("id")).spinner({value:1, min:0, max: data.aoData[i]._aData['goods_quantity'], disabled:false});
                }
            };
            
            // begin table TODO:add search filter
            SP.loadTableInfo($("#detailTable"), options, $("#inputForm"));
            //add check & initial datatable
            initDataTable();
        }

    };

}();