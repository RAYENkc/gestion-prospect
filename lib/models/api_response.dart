

class APIResponse<T,Ta> {
 T data;
 Ta Id;
 bool error;
 String errorMessage;

 APIResponse({this.data,this.Id,this.errorMessage, this.error=false});

}