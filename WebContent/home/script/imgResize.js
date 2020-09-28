function resize(img, wid, hei) {
    alert("!!resize");
    // 원본 이미지 사이즈 저장
    var images = new Image();
    images.src = img.src;
    
    var width = images.width;
    var height = images.height;
    
    // 가로, 세로 최대 사이즈 설정
    var maxWidth = wid; // 원하는대로 설정. 픽셀로 하려면 maxWidth = 100  이런 식으로 입력
    var maxHeight = hei; // 원래 사이즈 * 0.5 = 50%

    // 가로나 세로의 길이가 최대 사이즈보다 크면 실행  
    if (width > maxWidth || height > maxHeight) {

        // 가로가 세로보다 크면 가로는 최대사이즈로, 세로는 비율 맞춰 리사이즈
        if (width > height) {

            resizeWidth = maxWidth;
            resizeHeight = Math.round((height * resizeWidth) / width);
            
            if (resizeHeight > maxHeight)
                resizeHeight = maxHeight;
            
            // 세로가 가로보다 크면 세로는 최대사이즈로, 가로는 비율 맞춰 리사이즈
        } else {
            resizeHeight = maxHeight;
            resizeWidth = Math.round((width * resizeHeight) / height);
            
            if (resizeWidth > maxWidth)
                resizeWidth = maxWidth;
        }

        // 최대사이즈보다 작으면 원본 그대로
    } else {
        resizeWidth = width;
        resizeHeight = height;
    }
    
    // 리사이즈한 크기로 이미지 크기 다시 지정
    img.width = resizeWidth;
    img.height = resizeHeight;
            
}

//변경전
/*function itrResize(imgList, wid, hei) {
    for ( var i = 0; i < imgList.length; i++) {
        resize(imgList[i], wid, hei);
    }
}*/

function resizeDetail(img, wid, hei){
    
//  setTimeout(timeoutResizeDetail(img, wid, hei), 500);
    // 원본 이미지 사이즈 저장
    
    var images = new Image();
    images.src = img.src;
    
    var width = images.width;
    var height = images.height;
    
    // 가로, 세로 최대 사이즈 설정
    var maxWidth = wid; // 원하는대로 설정. 픽셀로 하려면 maxWidth = 100  이런 식으로 입력

    // 가로나 세로의 길이가 최대 사이즈보다 크면 실행  
    if (width > maxWidth) {

        resizeWidth = maxWidth;
        // 최대사이즈보다 작으면 원본 그대로
    } else {
        resizeWidth = width;
        
    }
    
    // 리사이즈한 크기로 이미지 크기 다시 지정
    img.width = resizeWidth;
    
    img.style.display = "";
}

function fitImageSize(obj, href, maxWidth, maxHeight) {

    image.onload = function(){
            
        var images = new Image();
        images.src = img.src;
        
        var width = images.width;
        var height = images.height;
        
        var scalex = maxWidth / width;
        var scaley = maxHeight / height;
        var scale = (scalex < scaley) ? scalex : scaley;
        if (scale > 1)
        scale = 1;
        obj.width = scale * width;
        obj.height = scale * height;
        obj.style.display = "";

        };
    image.src = href;
}