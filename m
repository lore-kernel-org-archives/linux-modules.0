Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8280F35DA42
	for <linux-modules@vger.kernel.org>; Wed, 15 Apr 2026 05:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776230101; cv=pass; b=A1IFbtvnU0LGqLJr+eFp9WT/S1mVH0476bCsir4K20hnEz3terNvVOoJKYGjwLtGu1g1wFOcR11b6fjQlDo+0GyZb8zgzUEHJj1m+swP5sDuuw59MXQ1qjG9jptk95g5UrKo/J7Q33wv1AbcG9HmDwYzdK+AIHYtC11mH928uZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776230101; c=relaxed/simple;
	bh=EEsEjaszIy6U1t2M0AT9FWo5sHsTueLI/JTM8CIT+Cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W5Jq1tdhq9FMTsvWjr0P3LRqf/MvFkf/AdPRGYR4mmjzHzmybMgoZMcC6or06WKGiNxUflIuFEYFpDNv8HmzjbPU4A1C2ckaVSuh92ckeK2KHxQPIWcPVQIZszSWDGef10Spo/rBGPxhLy3YpsME25RmZq/PEvJCdfMBqWk+7bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mG54uMr0; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mG54uMr0"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d7e23defbso1245381f8f.0
        for <linux-modules@vger.kernel.org>; Tue, 14 Apr 2026 22:14:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776230098; cv=none;
        d=google.com; s=arc-20240605;
        b=I1kpPlcGKzPeUVrrZ3b4F2n5O5Lfvzi2XZUBSWYM1Zpd/HxTydeLZ4Z6N5ryVoHzrb
         Wpt2X2dnv4Tyxl9qC1W6vEmTRxt2X+lmPQ8HaHo6uxYCG2H2rVSaegR2+dGlwBzBmnUa
         DQJ6eHpzXOeq9/Bbk6rR+vWtcqjyAOMR9uPVeaXkEVZQhxkHnNdFZCr48JqQ/B2gw8NT
         YpDoRObZW4P/qDNKDsLdGapBjOM79nS64Kja3r5OD2N2bUyiMpYnynapYhE6WYXpsrsi
         Mcl/sDBceqWfZlAXck2zw9sdf8gSjtdS8AaanjTUU2/akd2VQw9KiS41nS92wHdlwuwF
         MsvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EEsEjaszIy6U1t2M0AT9FWo5sHsTueLI/JTM8CIT+Cc=;
        fh=XUWG25JjUSB8/fdY8QohRai7mJh7oyLW9qRIVIXXAHQ=;
        b=eHqIG6xpNpgMJ9/rRTxmgiJPi7VLLj/H8Oge/G/GAACH2iuGruNit07OdnW1/Rbkwx
         UhG9K9S6uJJ6ZYr4ag0h1gRltjUc/Tqhca9CNJ6sxfQJa9+Pr8UC8Axi9eB0dbNsPcb4
         63ANOipi1hKwE0zgkoILC6A62HGxTT301srxt+cgEZMYSX9B+Sb2bsDe62xdca9IGGsx
         unbaURpUYpI3Ng0vd2LrMqe83tkENE2MlW+y+YXoQgGMbLfN/sWvsItY7sbxBRS2e9n0
         Tj3GSh9/vuVLCJcKWh8nZGq3vbS3nSJ8yekkcEbRA64kHSxkKYLf+R+4VZr7KBPPxS7l
         bFlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776230098; x=1776834898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEsEjaszIy6U1t2M0AT9FWo5sHsTueLI/JTM8CIT+Cc=;
        b=mG54uMr0TsQKx1KXocAfVD8V0Vqnh+Ne7LzHnTgerjFRAgoXR1AHoUuhI5nzI/L5Nj
         WwedGBVHnMCsYjPMsQ2HIJBvTRyibNFilmnwVzFJBswDcNXe0QedNGUIpCBDX+S46LER
         gT4QA8rLzQcgxglcRfpMgK14NLpjR/nHhL1lV/SjMolOFDABJRD9dTgaNLT+W5V0F0Fj
         gQGVDo3WaguxebcxK3OCCRkI2AtSHqLEChNz84p8rSBFs/sU9nlBHGyJH8LpIjJ7kJ81
         NnmzTy2ffnz9HtK4gCb5SnrdI8OxZzFKnE18xn7g4bwiSVsBarLQ0a1wsjx2/5+s8MYy
         wp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776230098; x=1776834898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EEsEjaszIy6U1t2M0AT9FWo5sHsTueLI/JTM8CIT+Cc=;
        b=UFyHqPd/fsAnSNckPGz5UcNlMvCirvDKjBSK288bMlMnmprEPjFTtn30T1V06Bipr2
         Woh0/TJ6hrlMnLcqFbkiNqgL0rSOGO/I2rPf7nouS7dPCP4uYUWxFtsbXxGcuEqynniJ
         LLg/jMfD2GrsescmOePo3SAwVrIWktud2PXaOzJiXsuvrZ0haAAvtzwL7APNL+Zkcm0Z
         quuGhyF7qHvImx0fOzyMBSOUMWpTPf+K2sjiW9qCeRJtGJIv+4lxJI5yUVsz/ev+TV6E
         YSEzXIdm+pXQfN5lBjnZyuuChAuwwQFW0aeeQCTctKN4Vn/8G9wZmh5VmVAxWK/gOksn
         v7tw==
X-Forwarded-Encrypted: i=1; AFNElJ8FHGwHrtA7iGdy4kWuT6QxPSgZWNJw8WkMbjTMO5KcAONk5ZCNMAs+5C5AL4GXKdw36lzh8XyWnSF//ZI7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz76+KA82sT89eExq3PYmzcFZi3WMREEVGwasszCQOmXbC7PcwF
	H/gy6EaZ3+HweJS9lMkAj603pHe66RwN7nMDSxtVmdg2kOy/S8MwNjaH0wzetn7mBG5FVNc7EyH
	BFSfT+ISLjcVghUo7y4LQJSEfykVSV8Y=
X-Gm-Gg: AeBDiessfuH3Uhno20fnh5oA2Bgg19Q7LWawCyX9l0XW64KTsVrd8eHtn5qJg1fOt3H
	GyXu5Av/qrIm+Nh431sNXVgOqW4HlCZtmpe/EjKeDQSuHIbzYJBzZgcbI6xfSwSlcjgA4+ncosI
	xnYHyu7MmSIougrpTwOAepdqX8JDc54w73beV2FVMYi7dHLeM/yn5EQTRrkhmoHLi7HeqUvkCk7
	sNFF75Xfuv7MjfBpmDOrqoVd0Ngw7cK53KqHyeZ37r5sCcFWSVDw9J4Sevdf2LjZ7kNlLDlSIc4
	w1TQd0EeTPUwq2IYaoLwp0x9+WAYKl+5WpL39tuGaD+qFdpi5U37OQB7tOkMnS4VgClzh6wtybB
	4h7BG2IHEilV4bzi6BonRya9G036zPRk8XLvB
X-Received: by 2002:a05:6000:144e:b0:43d:c95b:c46f with SMTP id
 ffacd0b85a97d-43dc95bc595mr9486630f8f.38.1776230097765; Tue, 14 Apr 2026
 22:14:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410131343.2519532-1-petr.pavlu@suse.com> <20260414203418.GA1022044@ax162>
In-Reply-To: <20260414203418.GA1022044@ax162>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Apr 2026 22:14:45 -0700
X-Gm-Features: AQROBzB7aDoLUZcZIDwk4xH7Hwd8TPccwBB9YE5L3c-gyNToBmQS1K57YgPiZRA
Message-ID: <CAADnVQKnWftcW0gk8HgFPLXuBf81+mqHMMds3fRmXHgOrRE-1g@mail.gmail.com>
Subject: Re: [PATCH] kbuild/btf: Remove broken module relinking exclusion
To: Nathan Chancellor <nathan@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Alan Maguire <alan.maguire@oracle.com>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Nicolas Schier <nsc@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Sasha Levin <sashal@kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-modules@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 1:34=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> On Fri, Apr 10, 2026 at 03:13:29PM +0200, Petr Pavlu wrote:
> > Commit 5f9ae91f7c0d ("kbuild: Build kernel module BTFs if BTF is enable=
d
> > and pahole supports it") in 2020 introduced CONFIG_DEBUG_INFO_BTF_MODUL=
ES
> > to enable generation of split BTF for kernel modules. This change requi=
red
> > the %.ko Makefile rule to additionally depend on vmlinux, which is used=
 as
> > a base for deduplication. The regular ld_ko_o command executed by the r=
ule
> > was then modified to be skipped if only vmlinux changes. This was done =
by
> > introducing a new if_changed_except command and updating the original c=
all
> > to '+$(call if_changed_except,ld_ko_o,vmlinux)'.
> >
> > Later, commit 214c0eea43b2 ("kbuild: add $(objtree)/ prefix to some
> > in-kernel build artifacts") in 2024 updated the rule's reference to vml=
inux
> > from 'vmlinux' to '$(objtree)/vmlinux'. This accidentally broke the
> > previous logic to skip relinking modules if only vmlinux changes. The i=
ssue
> > is that '$(objtree)' is typically '.' and GNU Make normalizes the resul=
ting
> > prerequisite './vmlinux' to just 'vmlinux', while the exclusion logic
> > retains the raw './vmlinux'. As a result, if_changed_except doesn't
> > correctly filter out vmlinux. Consequently, with
> > CONFIG_DEBUG_INFO_BTF_MODULES=3Dy, modules are relinked even if only vm=
linux
> > changes.
> >
> > It is possible to fix this Makefile issue. However, having the %.ko rul=
e
> > update the resulting file in place without starting from the original
> > inputs is rather fragile. The logic is harder to debug if something bre=
aks
> > during a subsequent .ko update because the old input is lost due to the
> > overwrite. Additionally, it requires that the BTF processing is idempot=
ent.
> > For example, sorting id+flags BTF_SET8 pairs in .BTF_ids by resolve_btf=
ids
> > currently doesn't have this property.
> >
> > One option is to split the %.ko target into two rules: the first for
> > partial linking and the second one for generating the BTF data. However=
,
> > this approach runs into an issue with requiring additional intermediate
> > files, which increases the size of the build directory. On my system, w=
hen
> > using a large distribution config with ~5500 modules, the size of the b=
uild
> > directory with debuginfo enabled is already ~25 GB, with .ko files
> > occupying ~8 GB. Duplicating these .ko files doesn't seem practical.
> >
> > Measuring the speed of the %.ko processing shows that the link step is
> > actually relatively fast. It takes about 20% of the overall rule time,
> > while the BTF processing accounts for 80%. Moreover, skipping the link =
part
> > becomes relevant only during local development. In such cases, develope=
rs
> > typically use configs that enable a limited number of modules, so havin=
g
> > the %.ko rule slightly slower doesn't significantly impact the total
> > rebuild time. This is supported by the fact that no one has complained
> > about this optimization being broken for the past two years.
> >
> > Therefore, remove the logic that prevents module relinking when only
> > vmlinux changes and simplify Makefile.modfinal.
> >
> > Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
>
> If the BPF folks want to take this since it deals with BTF:
>
> Acked-by: Nathan Chancellor <nathan@kernel.org>
>
> Otherwise, either Nicolas can take this for 7.1 or I will pick it up for
> 7.2 when 7.1-rc1 is out.

Alan, Ihor,

As resident btf gen experts, Please take a look.
