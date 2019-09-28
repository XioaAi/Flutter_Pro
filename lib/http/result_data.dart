class ResultData {
  dynamic data;
  int code;

  ResultData(this.data, this.code);

  getResultMessage(ResultData resultData){
    switch(resultData.code){
      case 200:
        return '成功';
        break;
      case -1:
      case -2:
        return '网络超时,请检查网络';
        break;
      case -3:
        return '接口错误';
        break;
      case -4:
        return '未知错误';
        break;
    }
  }

}