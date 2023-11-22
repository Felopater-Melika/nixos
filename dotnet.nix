{
  aspnetcore = {
    type = "aspnetcore";
    version = "8.0.0";
    srcs.x86_64-linux = {
      url = "https://download.visualstudio.microsoft.com/download/pr/257bdcc7-cbfd-4680-964a-cbe8e9160bca/ac0cbf19d897ba51ae004b4146940a0a/aspnetcore-runtime-8.0.0-linux-x64.tar.gz";
      sha512 = "c0aa3a926d6c2bc0d4cc14f5d7677a4592111bf3ebefa65c5273c4b979a6e2b5d58305a5aaf4ac78f593b46605ec02f40b610dcbff070b1d8cf8ddc656cac7dc";
    };
  };
  runtime = {
    type = "runtime";
    version = "8.0.0";
    srcs.x86_64-linux = {
      url = "https://download.visualstudio.microsoft.com/download/pr/fc4b4447-45f2-4fd2-899a-77eb1aed7792/6fd52c0c61f064ddc7fe7684e841f491/dotnet-runtime-8.0.0-linux-x64.tar.gz";
      sha512 = "16a93af328bcf61775875f4007c23081e2cb7aa8e2fba724aea6a61bc7ecf7466cc368121b08b58ac3b72f68cb67801c68c6505591eb35f18461db856bb08b37";
    };
  };
  sdk = {
    type = "sdk";
    version = "8.0.100";
    srcs.x86_64-linux = {
      url = "https://download.visualstudio.microsoft.com/download/pr/5226a5fa-8c0b-474f-b79a-8984ad7c5beb/3113ccbf789c9fd29972835f0f334b7a/dotnet-sdk-8.0.100-linux-x64.tar.gz";
      sha512 = "13905ea20191e70baeba50b0e9bbe5f752a7c34587878ee104744f9fb453bfe439994d38969722bdae7f60ee047d75dda8636f3ab62659450e9cd4024f38b2a5";
    };
    packages = { fetchNuGet }: let version = "8.0.0"; in [
      # These should all have bad outdated sha256s? I guess maybe none of them
      # have changed since the release candidate actually.
      (fetchNuGet { pname = "Microsoft.AspNetCore.App.Runtime.linux-x64"; inherit version; sha256 = "1qcmw41rbk56y7l79f9xqli44f8xa7rqi2bnncfngfbd54q3ijcj"; })
      (fetchNuGet { pname = "Microsoft.AspNetCore.App.Ref"; inherit version; sha256 = "0za8iyskzp7f9mjn8nizz3wjmrpylyv24a70vwavbq0h0h8rplsm"; })
      (fetchNuGet { pname = "Microsoft.NETCore.App.Host.linux-x64"; inherit version; sha256 = "12yxilcrlwkwrjiyl72sdryjwh1ilxnqq51zm5r10gadips2rzqq"; })
      (fetchNuGet { pname = "Microsoft.NETCore.App.Runtime.linux-x64"; inherit version; sha256 = "04h64nkpxrkp63p52csb4nrkyg8l1gg6r0m3xzl0h8303w88wwi3"; })
      (fetchNuGet { pname = "Microsoft.NETCore.DotNetAppHost"; inherit version; sha256 = "1h36s9sk8dx8dj5g0dkpcnl2g31jbibjal7344zcs6s7d7zjifc5"; })
      (fetchNuGet { pname = "Microsoft.NETCore.DotNetHost"; inherit version; sha256 = "1zggzn0z7clh6sic4hja5arhhraaldna4pyprxk88hkfs2h7k3s5"; })
      (fetchNuGet { pname = "Microsoft.NETCore.DotNetHostPolicy"; inherit version; sha256 = "1m8rvvlglivcrqadqjfggrh55c1sm1xyw3fd354v7xxpyd7nsak2"; })
      (fetchNuGet { pname = "Microsoft.NETCore.DotNetHostResolver"; inherit version; sha256 = "0rr4xpy6l7pm4zqr2faqihx7qpia9w3y81bzk0zn9rs2wa2g3pj1"; })
      (fetchNuGet { pname = "runtime.linux-x64.Microsoft.NETCore.DotNetAppHost"; inherit version; sha256 = "06sq2dsxg1gl3g5g2x9y2snh9xczi09ci90mb4im21x2dd5i91m2"; })
      (fetchNuGet { pname = "runtime.linux-x64.Microsoft.NETCore.DotNetHost"; inherit version; sha256 = "0bmhncabzz56r2ac46k1jqsjzgaflvnycbwkh9ksdywm91fcca8k"; })
      (fetchNuGet { pname = "runtime.linux-x64.Microsoft.NETCore.DotNetHostPolicy"; inherit version; sha256 = "01q00rdyg4dby0zvfkzc8sgyn2434bpzfzjxv3xpc4am05n7nikf"; })
      (fetchNuGet { pname = "runtime.linux-x64.Microsoft.NETCore.DotNetHostResolver"; inherit version; sha256 = "1n55lqdriy3kvxmcg2kfgri6si4avf6hi7hxl3pxi3y7ki2aqgq6"; })
      (fetchNuGet { pname = "Microsoft.NETCore.App.Ref"; inherit version; sha256 = "1l9a6flcj2ysxp0msvdz3p9zj6rc3r8dvr7gngn0qh17nklifk4x"; })
      (fetchNuGet { pname = "Microsoft.NETCore.App.Runtime.Mono.linux-x64"; inherit version; sha256 = "1bykc1r1ljvqqz6v5qzvh2zqzbiav8983657fn1yn5qwdqrfc19l"; })
      (fetchNuGet { pname = "Microsoft.NETCore.App.Crossgen2.linux-x64"; inherit version; sha256 = "07p2gz8j3pvq6fj1ikp65hzyhw8f76qbsap7ri90myhzy92cfqd7"; })
      (fetchNuGet { pname = "runtime.linux-x64.Microsoft.DotNet.ILCompiler"; inherit version; sha256 = "1fipxybzd7vah2y5rndb5kpn2n8mqcizp2m1lbi4fwi4mlmc6mqf"; })
  ];
  };
}
