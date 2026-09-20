Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1C61A0B15
	for <linux-modules@vger.kernel.org>; Sun, 20 Sep 2026 17:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789925153; cv=pass; b=pGipO7Tk9jqcAVEBpldMfwriPS6F4IRohakp17dyN2x+YSVrU7QTNqKhfKuABfyW9mhW6n8tNXVjXV5rjGeKNK7R9SiRsoNWVb9URSkJp1Z81cK5Ixsy5qhSA9mbUq4mbeq3RX3xlklMIy4cH+PML20Rvym5nQ3Y7A/ZB7LU4HY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789925153; c=relaxed/simple;
	bh=UfUPUMvGuoO9T8NbtoMUnIBUq7sjsNXSSIXwRVTqF64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ResmwHChoIzYfecNX82tua7VSTtz6V5ZrPuNm/wiYaZe/DQKjRqZvgJX78ii5Gxme2TBTEFaQBFaPYy5pMvtLSo9hS6E1sXKCqLaezs/qzrrp847tRR0DbXZrmyzFOysEuVfhkxaGymmcn+O6+6fJjgZWiYWrbeTZ3K6ePWgNlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mh2eFAhN; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mh2eFAhN"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-85d43daa8f4so14091627b3.3
        for <linux-modules@vger.kernel.org>; Sun, 20 Sep 2026 10:25:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789925151; cv=none;
        d=google.com; s=arc-20260327;
        b=ltAASv/JF1BpWi1fBKWz9ktUxTaSaK9mSoO4I9o4HeXiZWCMmQtq8pDdPAnIlO1M6p
         08Jg/Bc2NDYy8Zw78Rmt4w9KG8IqV5UfA+u/ohDW2KCvxRzn7/u0X20xZqjyzJF8SQjC
         bcg6villD2ORJ6gg3Eu/xbyQDwvtSIDMaUOOMPe1gttYJcsit7l+dttB8YRf9/wTUcU5
         Hsm8BreyuzygxBuxWOkSoJjzUK7ftJbbV3khMHH7gXn2BQgoesNdQ2yya/iqLR3Wpqfm
         veeqSqypClGcnugH9QP0c2KlcBAVCS9ndwYDJW8F6UwgU4l2oI6lkg/Idvs8Bb3fIRi1
         fiFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3OfbjdZ7JhnmWB3SFJinxtG8xu+EcVyQidKsmmu69Ws=;
        fh=5cs6b6d7Xpq2ANmcE1sW6J73OLOoOdfaXy4E0BsYxz0=;
        b=ksi78rt/+Jz0sXhfFhV1vr2by+NiWs7LIWYnbS9mo9FWFpwHp59c3g9+m3f9859TKh
         KhtqfvwLCFoc4F23KIIn6tZSpomNopL2qjbATwkLzKANxSqNiNIPsDGJD3gnoGwvdYJn
         IfVw1Y1tGjo+SW2H3XcsuQN/lYqsKNqHEPQvCjrbhO1qk5aumfHp1RPAdTToXuQ2yWuz
         oXSC44N1EdJP4DLE+5tfK92xOfKZozAfW2rv10YK2cIP+6aICn7B4fffVsDw1lljCWss
         NKlq/MoZZIbq0a3I8a+1F1kKoalebZvIXkDuZGBCZ/T9mNdQMMSXlK+3XRLEE2ucqAfH
         FfOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789925151; x=1790529951; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3OfbjdZ7JhnmWB3SFJinxtG8xu+EcVyQidKsmmu69Ws=;
        b=mh2eFAhNVsrDcxvNjA2WCgPBBwKxERz0f3FPDn3IwozjgfPDLi0AU76q/WshZw7mcI
         2W8eHl+MpYoob0p35HguO4FkZ5ocu9Un0yEAaZs1yRGmcIgS4KZ9NkMRWZ5443SoCHgs
         qH7NTf8DAoVHMp/rGA0z/K2lpqEOMqhQlleiozpxIwtEQfQW9IKNoTZRxzuxidvlnRhc
         kHT1NJNaGI9S2oI4ZanTgMYHTjnvgD8fYzxtj/Nybf2b6jUFmnTKr05VGwm7GSCthRyB
         dXh1qISO5pnIDpBShKJ+xZjCp2RSTWMiDD2i26xVYsWNJhL0lr2j0ffbVcfilPhO8ELV
         nWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789925151; x=1790529951;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3OfbjdZ7JhnmWB3SFJinxtG8xu+EcVyQidKsmmu69Ws=;
        b=j2dOqivTeLaZ6N67qJNhtXctPxLI/9cDM8v+Ap7roNDRbeTq5QoNP2X1efGWuarPup
         Wz0rd8I+YiTr/SYYwg0het2Sc9pNkQBfZQXd1vOQtV1hUCHFyBFPoqGZ4q/zDX/gkA9j
         AX8TCUC/3iB7rvBJMo3u5Mn8o0u/J09kwaMBmcYUP0J26TttE/5Jw+Xb+vOmbgcmrnvq
         7YffapKmiEyFNBXbnfto3b6daWyk/HgzGll9eW86E1W9sI7DxUTQXSNuQS4wzCKDqymg
         VWSL1dgW07f2pHeSXxSW2GVLE2rFadBVSix4YBwDS2iVdBdQH7TDMR5MMVQu9wRrXpu6
         f9XQ==
X-Gm-Message-State: AFuF++mp7C7+g1IX2KKEzR1cnmcwPov4chwIE2BMiM1xgbdWwSOICSwS
	GN0v6i0CtcODQejdXaPS4x/zisCUpFDPSvSe0mGuPMJeL4iN9mMFk8TA0siv1OpjzJEtEOVA/ON
	IyA95lajVBXNaKIgN9RYtfRoTz9IV4vc=
X-Gm-Gg: AYBFou01PD91AmzLaWrPCrp6YJRfICzdLpCrpxX3njsdzXOdIr4L51bSp1p92IOoQBf
	KizOCq5iYyYj9Fw5JpQ670YrFZ98refHu3YhruwdoSLrMKa1WRjslJtF6tDCLZfBNYG9xK9YPg8
	6azJ3kIeqWDtbIqtoVCcBfng56+JCuZ9Y4u3jPXl9vdr0T0MF8Bbzx70BHPcrZFXy3MmyAa9aU5
	DX3E3MEE161O0b3m02N9SOHWPeIA73pfiheQ4E24HqM7SuNzumf3plqy+E7xCJPNpEjbN9Ml9QW
	VhKjXhBlLBOR9YhYEen4Mwmj3JD0jEwbbCiOjeObVX2xRddnjpYrSHfP0ieRn5yf1NOMCtQPOP+
	OeTyOHJ8WAgBsi2sHjXEsM1DSBkT1Edtkjw==
X-Received: by 2002:a05:690e:bc9:b0:66e:45c8:fc92 with SMTP id
 956f58d0204a3-6717fcac9f3mr2366498d50.23.1789925151025; Sun, 20 Sep 2026
 10:25:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916-dd-cmap-part2-clean-v10-0-af4cf4767707@gmail.com>
 <20260916-dd-cmap-part2-clean-v10-24-af4cf4767707@gmail.com> <20260916162426.BF6241F000FF@smtp.kernel.org>
In-Reply-To: <20260916162426.BF6241F000FF@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Sun, 20 Sep 2026 11:25:24 -0600
X-Gm-Features: AcwNN1U4PdC2-ak_eLI6nDpyzmI74MRgcM2U5SRdaLHhoM3APxQAdxw6Wk6ZIJ0
Message-ID: <CAJfuBxxGEYMZxChjRzG02tPM-WtVnjWM5mMCcfaJN9yX1vNTUA@mail.gmail.com>
Subject: Re: [PATCH v10 24/38] selftests/dyndbg: Enable FT_classmap_inheritance
To: sashiko-reviews@lists.linux.dev
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 10:24=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] selftests: dyndbg: load-time parameters truncated due to shell=
 quoting bug
> --
>
> commit f2f3cad7addd566a67a218932463053f35d4d782
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
> > index 09a8dbf239dcf..51338ebc74bf8 100755
> > --- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> > +++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> [ ... ]
> > @@ -298,6 +299,78 @@ function FT_basic_queries {
> >      ddcmd "file $f =3D_" "$f"
> >  }
> >
> > +function FT_classmap_inheritance {
> > +    v_echo "${GREEN}# TEST_MOD_SUBMOD ${NC}"
> > +
> > +    ifrmmod test_dynamic_debug_submod
> > +    ifrmmod test_dynamic_debug
> > +
> > +    # modprobe with plain-old +p & 3 class enablements
> > +    my_modprobe test_dynamic_debug \
> > +     "dyndbg=3D+p;class D2_CORE +pf;class D2_KMS +pt;class D2_ATOMIC +=
pm"
>
> [Severity: Medium]
> Are these load-time parameters truncated during module load due to how th=
e
> shell handles quotes?
>

yes, Ive seen it locally.
it is the reason for comma-terminator patch later in series.
next rev adds 2nd level of quoting here,
then switches to comma-terminator once that patch is added.


> When bash evaluates and strips the double quotes before executing modprob=
e,
> modprobe constructs the kernel options string without adding quotes aroun=
d
> the parameters. The kernel's parse_args() function (using next_arg() in
> lib/cmdline.c) splits module parameters at unquoted spaces.
>
> This means it treats D2_CORE and +pf as separate unknown parameters. The
> dyndbg parsing logic executes +p but fails on the truncated class command=
,
> completely ignoring the actual class configurations.
>
> Does this defeat the test's intent to verify load-time classmap inheritan=
ce,
> allowing it to pass only because the golden hash recorded the incorrectly
> applied +p state?
>
> It appears this space-splitting flaw persists through the end of the patc=
h
> series, and the newly added FT_test_classes also replicates it.
>
> > +    verify_control_slice '\[test_dynamic_debug\]'
> > +
> > +    set_param 5 /sys/module/test_dynamic_debug/parameters/p_level_num
> > +    verify_control_slice '\[test_dynamic_debug\]'
> > +
> > +    my_modprobe test_dynamic_debug_submod
> > +    verify_control_slice 'test_dynamic_debug_submod'
> > +
> > +    # fresh start, to clear all above flags (test-fn limits)
> > +    ifrmmod test_dynamic_debug_submod
> > +    ifrmmod test_dynamic_debug
> > +
> > +    # load submod, which loads supermod
> > +    my_modprobe test_dynamic_debug_submod \
> > +     "dyndbg=3D+p;class D2_CORE +pfs;class D2_KMS +pts;class D2_ATOMIC=
 +pmf"
>
> [Severity: Medium]
> Does this submod load suffer from the same space-splitting issue?
>
> > +    verify_control_slice 'test_dynamic_debug'
> > +
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-dd-cmap-=
part2-clean-v10-0-af4cf4767707@gmail.com?part=3D24
