//
//  NetInterface.h
//  DeliciousFoods
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#ifndef DeliciousFoods_NetInterface_h
#define DeliciousFoods_NetInterface_h


//美食杂志  1.城市接口(置0) 表示全国  2.参数 显示页数
#define kMagazine @"http://api.meishixing.com/foodzine/weekly/list/city_id=0&state=2&page=%ld"

//第一个接口  本月美食best 喜欢最多like_most (各地美食推荐)
//各地美食(展示) 1.城市接口(置0)表示全国 第2个经度(置0) 第3个纬度(置0) 第4.参数 显示页数
#define kDeliciousFood @"http://api.meishixing.com/picture/picturelist/%@/city_id=0&session_id=000013d2d0e16e5d41e56494b457c23a4e08b5&lat=0&lng=0&page=%ld"

//全国达人排行榜 参数城市接口 (置0) 表示全国
#define kTopUser @"http://api.meishixing.com/user/user/top/session_id=000013d2d0e16e5d41e56494b457c23a4e08b5&city_id=%ld"

//菜谱详情接口  第一个是菜谱名字 第二个是显示条数
//搜索也是这个接口 只是输入的关键字不同
#define kMenu @"http://caipu.yjghost.com/index.php/query/read?menu=%@&rn=%ld&start=%ld"

// 零食详情界面  接口表示哪一类详情页 (点击进去时webView)
#define kSnacks @"http://www.msshuo.cn/app/hot/raiders?tpl=raiders&crowd_id=%ld&uid=null"

//厨房秘籍 参数 厨房 美容 减肥
#define kKitchen @"http://meishitaotao.com/taotao/json/strategy/strategylist.jsp?page=%ld&tagtext=%@&typeid=11,16,18"

//首页点击
#define kMyHomeFood @"http://api.meishixing.com/foodzine/weekly/detail/session_id=000013089dea8a5146f39c82ea549162587cae&foodzine_id=%@&page=%ld"

//首页
#define kHomeFood @"http://api.meishixing.com/foodzine/weekly/list/city_id=3&state=2&page=%ld"





/*
 //第一个接口 本周美食 best_week 本月美食best 喜欢最多like_most
 //第二个 城市接口
 //第三个经度 第四个纬度
 //第五个 页数
 
 //#define kDelicious @"http://api.meishixing.com/picture/picturelist/%@/city_id=%d&session_id=000013d2d0e16e5d41e56494b457c23a4e08b5&lat=%lf&lng=%lf&page=%ld"

 //// 附近美食
 ////第1个经度 第2个纬度 第3个附近多少米 (1000 2000 3000)
 //#define kNearFood @"http://api.meishixing.com/search/nearby/recommandplace/lat=%lf&lng=%lf&page=%ld&correct_offset=0&distance=%ld&price=0~200000&food_category_name="

 ////本周热店 1.城市接口 第2个经度 第3个纬度 第4.参数 显示页数
 //#define kTopweek @"http://api.meishixing.com/place/place/topviewweek/city_id=%ld&lat=%lf&lng=%lf&page=%ld"

 
 */








#endif
