Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802062798F8
	for <linux-modules@vger.kernel.org>; Thu,  1 Oct 2026 23:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790897113; cv=pass; b=TFJVlT2rx8osa3USdxi3qFovfKh+aBFp+1vb9AJejZJ70ql8GQI7jOCIv648IUuG6AcEMWnczixyhygmIh2Z7zIIFuu2Va8IAOxzXe+vYM2OM6I3PQGZIGzaCj5Odw9cFgWLBnIk4sEtLRhGK3i/DMc8i5ETKZZBsziTwl8jQ6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790897113; c=relaxed/simple;
	bh=w5DNQYe8bIFaazPMMSIcL7oDJikhQaw0m6GW64PTLGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RseSaYUWaHBSyroG3UjFWCujxaJhzMZCYWWHZ+dilJTRhvqaZAIaMeUeDfQTtCtj8GylXsXqeWzIhtHUzGch84CMSFjC9Zih6PxODeyOSOGLQaGfOuPZEqLObN5R0sCa5EP+/O14Tw7RVgCsBr9SIqjZ05jSPoU6EjWTO3z/rpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBWZKKak; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBWZKKak"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-671563fb8beso7287560d50.3
        for <linux-modules@vger.kernel.org>; Thu, 01 Oct 2026 16:25:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790897110; cv=none;
        d=google.com; s=arc-20260327;
        b=ldkEe2aQfLu2sPfAYBcEQCVsa6nID+Jy2xKN6WpznJuJpk9MD4qMrFEIxYlkbZleEs
         oLqfuXIKM3Fg63KcDKvY8N597aNsbEo8PMU3Q9C9glq33X5CJcL9MZpbgxyV7hxY+ro7
         FvcIvSlD/QJW7Lsp4LSXRZvUVrsUxLbqcV5XVA2APVayCo9+/cz6Ixa4qYgbrqYMlBxA
         rbQ14wMFTIXF2lll1TDf97wwpC9pv4g/H/OslXLB1DcNBxJ1r/A+8psgFmPiT5WCW/Oj
         Y4Ywcl/5NNKaEW437HeEoDa77ZSMDLAXhqgo8gnZmc6SFkAl5XJ95sGe+s8X7Dtmp2SW
         EM8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z7GpKJHYk0xmN9tpUhQVKePKwe5CIuT1Vrxc26cesaY=;
        fh=5cs6b6d7Xpq2ANmcE1sW6J73OLOoOdfaXy4E0BsYxz0=;
        b=ki+C5CcHT53V7OZWW5v0z9eGmYojQev6cHBOU7ZSCOe3g5+DX+wejukF/SZkDbeu7V
         8uwKuRNA6f3j0GRVOUOx4FppnZXngHDuEodJMvyuL2GMkeDsAuUEaH/G11qLdWipLKIc
         DVDP7V64dllpPKB1967bBqYap6I8TelGDYfIgkCVrTY5+RcQ/RJ+f2n2aESNhvHsASjr
         oVENOnLZNJwBlq1yMcJ+W72fJsJbn9KfPrySEjy2pxzS61+eh/NuUAFnGsN4a1fU+wM1
         IKPxNvERdf/gLvlF4tfRl7M/ZfcoPFx/92vkEXaw8I1CuDZrMr5yTHkRhfG1pStYYChc
         H+dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790897110; x=1791501910; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z7GpKJHYk0xmN9tpUhQVKePKwe5CIuT1Vrxc26cesaY=;
        b=ZBWZKKakaKWFyuig2ylBGLWWehzRYm5P8Uy2uBSgZVdX9hTQH+UK1RWlBx/mmWusrj
         3OQNRD/JCSyNED/yuLTJ0THydcxJi//o/nPGm/T1ltSQv92yyilaXMbOGGMsf7zwnpiA
         qbh+VAg5FaIqM+FN/wa9pD7T5OPuFmsODSXmQPbJZAQ8ClIo21W+DwroMQy5FBjolsi+
         81e0ymCWIWU87YpK0NeCcqzgNBnkkpUH+6vU/49Am90NsQgAytpp8DMMaI9oVBkMTbSQ
         TMqVfhZNUx3bM9p+01qH32fpNEOLdz9UkMICjFsySEsUs3i2v2h+3Ykgr+WDbHgfK3XT
         IQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790897110; x=1791501910;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z7GpKJHYk0xmN9tpUhQVKePKwe5CIuT1Vrxc26cesaY=;
        b=D5+ohlIk9jBy7AzjOACNpGpKpSn1YS49CexTmHBvVA8ds+7VftpBL6lYbPWvf/QlNp
         oX1+EFfboy6avCz5v1Dm0fW8ay/cgbZ6crNUIREuGZjhh+p6XWEyzT2V2myEqz9P3P5T
         Qko5fZayLCdQ55KHmpdNplOZBSh0ba+5iVLauEfoLfdKw06OU0Fh2uSidadq41LytasV
         GgfgBEEasVWuEnZXM+q7v3oilwvcU7cFCXNSmDomsQApzcts3pAkR6elYNkaxykbjv8r
         pzEXmlF8OHX/eYDBJIllQFVwOhjPcWtHU9zi4Tc/0zJVEsu9ufEfV7qt3btLPG5YsypB
         YdoQ==
X-Gm-Message-State: AFq9FYK08XB31hd5lD2VzApwSRVo1WcT4bcEYC//0BokXmD+efpzZfnd
	6I/B9pZc12DIzeODgG9C7uYs/1Z4iDQkYS8d4Xe0g3X6G5VnGQdtxRhSK/mYjy4sT/tYnPfuT0k
	F0cvbDfoH9KiHHFq7ikp3LeiNxVR1EQ86H7/x
X-Gm-Gg: AYBFou0H8mv1q4KwAqjTtI4BTPE5rD+6Th89ymwU7nDDsDB9TTTWBmKBASZsL/2eimG
	sUQVE9bLBEG6JW9aOnZXdfnNHZWmFuHIE81NDjjOmYV+AByImpSVaSTLcKY3J7hbQLFltl2CCII
	kGOgR29XCuh3ipDzzKmk/eCzrM9MNx2c67qIt5v2qIo2Q4jWs8OAs1C5iLkHOENKP07hZQpD0Am
	cpqbko5dM2cFLYzSSRMGfUmImSzcNowERs1wFhKepLiDrZX8TIWqGibdneUDmWF0CtzGE2dr1L7
	nEqys2CsTIQ9wOSLGcEC/S86sWPmGYwFf+Dd4Z6Sfd5K6tMj6AM4Wxi33PKtsogbH1F51VvNVAl
	WAZG0NcX3fznblQ7EDOfpbCHXaOmHAe7Dow==
X-Received: by 2002:a05:690e:80c:20b0:674:1e39:446 with SMTP id
 956f58d0204a3-677abff80d8mr347805d50.39.1790897110259; Thu, 01 Oct 2026
 16:25:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
 <20260923-dd-cmap-part2-clean-v11-24-9b6c217fdf2f@gmail.com> <20260923224520.0FC9A1F000FF@smtp.kernel.org>
In-Reply-To: <20260923224520.0FC9A1F000FF@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Thu, 1 Oct 2026 17:24:44 -0600
X-Gm-Features: AclHuK8BjtsIPOJOBV_6x7QlYWrq8f66IubOXehmbQGa_J9fPwf-nlNjvUt1OkA
Message-ID: <CAJfuBxyg=oJ59-2o8b9CGKeQvaYbTM6HXj6+C-zd+PmpKBmu8w@mail.gmail.com>
Subject: Re: [PATCH v11 24/38] selftests/dyndbg: Enable FT_classmap_inheritance
To: sashiko-reviews@lists.linux.dev
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 4:45=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] selftests: classmap inheritance hash check excludes submod
> - [Low] selftests: undocumented uncommenting of grammar testcase
> --
>
> commit 7d522a72bd526c1e41ef1a1e604e466e1e729843
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> selftests/dyndbg: Enable FT_classmap_inheritance
>
> Exercise classmap state inheritance between supermod and submod,
> verifying that class settings and controlling parameter states propagate
> from parent classmap definitions to dependent class users upon module
> load and during runtime reconfiguration.
>
> > diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b=
/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> > index c279c795867b6..5a805cb30e6cd 100755
> > --- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> > +++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> [ ... ]
> > @@ -189,7 +190,7 @@ function FT_grammar_ok {
> >
> >      # use 4 keywords (max 9 words inc flags)
> >      ddcmd "module foo file bar.c func buz class D2_CORE +_"  # 4 keywo=
rds
> > -    #ddcmd "module foo file bar.c func buz class D2 line 100 +_" # 5 k=
eywords
> > +    ddcmd "module foo file bar.c func buz class D2 line 100 +_" # 5 ke=
ywords
>
> [Severity: Low]
> Was this undocumented uncommenting of a grammar testcase intentional?
>
> It modifies the behavior of an existing, separate test in FT_grammar_ok w=
ithout
> documenting it in the commit message.
>
> [ ... ]
> > @@ -291,6 +292,78 @@ function FT_basic_queries {
> >      ddcmd "file $f =3D_" "$f"
> >  }
> >
> > +function FT_classmap_inheritance {
> [ ... ]
> > +    # Real-time mathematical proof that load-time (modprobe) parameter=
 parsing
> > +    # and runtime (sysfs write) parameter configurations are perfectly=
 equivalent!
> > +    local hash_modprobe=3D$(slice_and_hash_ddctrl '\[test_dynamic_debu=
g\]')
> > +
> > +    # Fresh load with default parameters, then configure them dynamica=
lly at runtime
> > +    ifrmmod test_dynamic_debug_submod
> > +    ifrmmod test_dynamic_debug
> > +    my_modprobe test_dynamic_debug
> > +    my_modprobe test_dynamic_debug_submod
> > +    echo 0x16 > /sys/module/test_dynamic_debug/parameters/p_disjoint_b=
its
> > +    echo 5 > /sys/module/test_dynamic_debug/parameters/p_level_num
> > +
> > +    local hash_sysfs=3D$(slice_and_hash_ddctrl '\[test_dynamic_debug\]=
')
>
> [Severity: Medium]
> Does this classmap inheritance hash check exclude the submodule?
>
> Because of the strict regex using escaped brackets, the grep strictly mat=
ches
> the parent module's section and filters out all [test_dynamic_debug_submo=
d]
> lines.
>
> Consequently, the hash equivalence check only proves the parent module re=
sponds
> correctly, ignoring the dependent submodule whose inheritance is supposed=
ly
> being tested in FT_classmap_inheritance.
>

The test does not ignore the submodule; earlier steps in
FT_classmap_inheritance explicitly verify submodule inheritance across
both modules via verify_control_slice 'test_dynamic_debug' against
the golden records database, and step 6 validates runtime logging.

However, broadening the step 5 modprobe-vs-sysfs equivalence check
to verify both modules simultaneously is a good improvement. For v12,
I've updated the pattern to '\[test_dynamic_debug*\]', proving that
both supermod and submod callsites match identically across load-time
and runtime parameter configuration.


> > +    if [ "$hash_modprobe" !=3D "$hash_sysfs" ]; then
> > +        echo -e "${RED}: Load-time vs runtime parameter equivalence ch=
eck failed!${NC}"
> > +        exit $ksft_fail
> > +    else
> > +        v_echo "${GREEN}: Proven: parameter load-time (modprobe) " \
> > +            "and runtime (sysfs write) are equivalent!${NC}"
> > +    fi
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-dd-cmap-=
part2-clean-v11-0-9b6c217fdf2f@gmail.com?part=3D24
