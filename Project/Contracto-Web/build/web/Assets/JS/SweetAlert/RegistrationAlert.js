/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

swal({
    title: "Success",
    text: "You have successfully registered!",
    type: "success",
    showConfirmButton: false,
    timer: 4000
});
setTimeout(function() {
    window.location.href = '../../Guest/NewClient.jsp'
}, 2000);