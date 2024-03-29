class RecommendProEntity {
	RecommendProData data;
	int errorCode;
	String errorMsg;

	RecommendProEntity({this.data, this.errorCode, this.errorMsg});

	RecommendProEntity.fromJson(Map<String, dynamic> json) {
		data = json['data'] != null ? new RecommendProData.fromJson(json['data']) : null;
		errorCode = json['errorCode'];
		errorMsg = json['errorMsg'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.data != null) {
      data['data'] = this.data.toJson();
    }
		data['errorCode'] = this.errorCode;
		data['errorMsg'] = this.errorMsg;
		return data;
	}

	@override
	String toString() {
		return 'RecommendProEntity{data: $data, errorCode: $errorCode, errorMsg: $errorMsg}';
	}


}

class RecommendProData {
	bool over;
	int pageCount;
	int total;
	int curPage;
	int offset;
	int size;
	List<RecommandProDataDatas> datas;

	RecommendProData({this.over, this.pageCount, this.total, this.curPage, this.offset, this.size, this.datas});

	RecommendProData.fromJson(Map<String, dynamic> json) {
		over = json['over'];
		pageCount = json['pageCount'];
		total = json['total'];
		curPage = json['curPage'];
		offset = json['offset'];
		size = json['size'];
		if (json['datas'] != null) {
			datas = new List<RecommandProDataDatas>();(json['datas'] as List).forEach((v) { datas.add(new RecommandProDataDatas.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['over'] = this.over;
		data['pageCount'] = this.pageCount;
		data['total'] = this.total;
		data['curPage'] = this.curPage;
		data['offset'] = this.offset;
		data['size'] = this.size;
		if (this.datas != null) {
      data['datas'] =  this.datas.map((v) => v.toJson()).toList();
    }
		return data;
	}

	@override
	String toString() {
		return 'RecommendProData{over: $over, pageCount: $pageCount, total: $total, curPage: $curPage, offset: $offset, size: $size, datas: $datas}';
	}


}

class RecommandProDataDatas {
	String superChapterName;
	int publishTime;
	int visible;
	String niceDate;
	String projectLink;
	String author;
	String prefix;
	int zan;
	String origin;
	String chapterName;
	String link;
	String title;
	int type;
	int userId;
	List<Null> tags;
	String apkLink;
	String envelopePic;
	int chapterId;
	int superChapterId;
	int id;
	bool fresh;
	bool collect;
	int courseId;
	String desc;

	RecommandProDataDatas({this.superChapterName, this.publishTime, this.visible, this.niceDate, this.projectLink, this.author, this.prefix, this.zan, this.origin, this.chapterName, this.link, this.title, this.type, this.userId, this.tags, this.apkLink, this.envelopePic, this.chapterId, this.superChapterId, this.id, this.fresh, this.collect, this.courseId, this.desc});

	RecommandProDataDatas.fromJson(Map<String, dynamic> json) {
		superChapterName = json['superChapterName'];
		publishTime = json['publishTime'];
		visible = json['visible'];
		niceDate = json['niceDate'];
		projectLink = json['projectLink'];
		author = json['author'];
		prefix = json['prefix'];
		zan = json['zan'];
		origin = json['origin'];
		chapterName = json['chapterName'];
		link = json['link'];
		title = json['title'];
		type = json['type'];
		userId = json['userId'];
		if (json['tags'] != null) {
			tags = new List<Null>();
		}
		apkLink = json['apkLink'];
		envelopePic = json['envelopePic'];
		chapterId = json['chapterId'];
		superChapterId = json['superChapterId'];
		id = json['id'];
		fresh = json['fresh'];
		collect = json['collect'];
		courseId = json['courseId'];
		desc = json['desc'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['superChapterName'] = this.superChapterName;
		data['publishTime'] = this.publishTime;
		data['visible'] = this.visible;
		data['niceDate'] = this.niceDate;
		data['projectLink'] = this.projectLink;
		data['author'] = this.author;
		data['prefix'] = this.prefix;
		data['zan'] = this.zan;
		data['origin'] = this.origin;
		data['chapterName'] = this.chapterName;
		data['link'] = this.link;
		data['title'] = this.title;
		data['type'] = this.type;
		data['userId'] = this.userId;
		if (this.tags != null) {
      data['tags'] =  [];
    }
		data['apkLink'] = this.apkLink;
		data['envelopePic'] = this.envelopePic;
		data['chapterId'] = this.chapterId;
		data['superChapterId'] = this.superChapterId;
		data['id'] = this.id;
		data['fresh'] = this.fresh;
		data['collect'] = this.collect;
		data['courseId'] = this.courseId;
		data['desc'] = this.desc;
		return data;
	}

	@override
	String toString() {
		return 'RecommandProDataDatas{superChapterName: $superChapterName, publishTime: $publishTime, visible: $visible, niceDate: $niceDate, projectLink: $projectLink, author: $author, prefix: $prefix, zan: $zan, origin: $origin, chapterName: $chapterName, link: $link, title: $title, type: $type, userId: $userId, tags: $tags, apkLink: $apkLink, envelopePic: $envelopePic, chapterId: $chapterId, superChapterId: $superChapterId, id: $id, fresh: $fresh, collect: $collect, courseId: $courseId, desc: $desc}';
	}


}
