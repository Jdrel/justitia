var tl = new TimelineLite();
var banner = document.getElementById("banner");
var hidden = document.getElementsByClassName("hide");
var copy = document.getElementsByClassName("copy");

//TweenLite.delayedCall(14,reset);

///////////////////
//  Animations:    

function animate(){
    var delay = 0.5;
    
    TweenLite.to("#overlay",.8, {delay:delay, y:0, x:0, autoAlpha:0, ease:Expo.easeOut});
    delay += 1;
    TweenLite.to("#visual",.5, {delay:delay, y:0, x:0, scale:1, ease:Expo.easeOut});
    TweenLite.to("#paper_tear",.5, {delay:delay, y:0, x:0, scale:1, ease:Expo.easeOut});
    TweenLite.to("#graphic",1, {delay:delay, y:0, x:-10, scale:1.1, ease:Expo.easeOut});
    
    delay += .5;
    TweenLite.to("#visual",5, {delay:delay, y:0, x:0, scale:1.1, ease:Expo.easeInOut});
    TweenLite.to("#logo",.8, {delay:delay, y:0, x:0, autoAlpha:1, ease:Expo.easeOut});
    delay += .1;
    TweenLite.to("#copy00",.2, {delay:delay, y:0, x:0, autoAlpha:1, ease:Expo.easeOut});
    delay += .1;
    TweenLite.to("#copy01",.2, {delay:delay, y:0, x:0, autoAlpha:1, ease:Expo.easeOut});
    delay += .1;
    TweenLite.to("#copy02",.2, {delay:delay, y:0, x:0, autoAlpha:1, ease:Expo.easeOut});

    delay += .8;
    TweenLite.to("#cta",1, {delay:delay, y:0, scale:1, autoAlpha:1, ease:Expo.easeOut});
    TweenLite.delayedCall(delay,addEventListeners);
    
    delay += 3;
    TweenLite.to("#cta",.01, {delay:delay, y:0, scale:1.1, autoAlpha:1, ease:Expo.easeOut});
    delay += .2;
    TweenLite.to("#cta",.01, {delay:delay, y:0, scale:1, autoAlpha:1, ease:Expo.easeOut});
    delay += .2;
    TweenLite.to("#cta",.01, {delay:delay, y:0, scale:1.1, autoAlpha:1, ease:Expo.easeOut});
    delay += .2;
    TweenLite.to("#cta",.01, {delay:delay, y:0, scale:1, autoAlpha:1, ease:Expo.easeOut});
}


//////////////////////
//  Prepare Banner:    

function reset() {
    TweenLite.set(hidden, {autoAlpha:0});
    TweenLite.set(copy, {y:0});
    TweenLite.set("#cta", {transformOrigin: "80px 570px"});
    TweenLite.set("#cta_hover", {transformOrigin: "80px 570px"});
    TweenLite.set("#visual", {y:140, scale:1.5});
    TweenLite.set("#paper_tear", {y:240});
    TweenLite.set("#graphic", {y:240, scale:.5});
    
    //Don't modify:
    banner.style.visibility = "visible";
    animate(); //<- call to animate
}

function smoothElements() {
    TweenLite.set(["div", "img"], {force3D: true, backfaceVisibility: "hidden", rotationZ: '0.01deg', z:0.01});
    banner.draggable = false;
    reset();
}
function bannerExitHandler(){
    console.log("exit triggered");
    window.open(window.clickTag);
}

function createBannerExit(){
    var bannerExit = document.createElement('div');
    bannerExit.addEventListener('click', bannerExitHandler, false);
    bannerExit.setAttribute('class', 'blockElement');
    bannerExit.style.zIndex = "100";
    banner.appendChild(bannerExit);
}

function mouseOver(){
    console.log('mouseover');
    TweenLite.to("#cta_up",0.2, {autoAlpha:0});
    TweenLite.to("#cta_hover",0.2, {autoAlpha:1});
}

function mouseOut(){
    console.log('mouseoout');
    TweenLite.to("#cta_up",0.2, {autoAlpha:1});
    TweenLite.to("#cta_hover",0.2, {autoAlpha:0});
}

function addEventListeners(){
    banner.addEventListener('mouseover', mouseOver); 
    banner.addEventListener('mouseout', mouseOut);
}

function initBanner() {
    smoothElements();
    createBannerExit();
    
    console.log('initiating banner');
}