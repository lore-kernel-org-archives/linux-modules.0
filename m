Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65CD4BE42D
	for <linux-modules@vger.kernel.org>; Wed, 16 Sep 2026 22:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789598606; cv=pass; b=PKEUy1W34nqXrujmckCnUL2myeK1u0H6BvGg+ZjNhsgs//XvIKGws+MPaScsnjKGjk//BTE9zgmzZSFA5H77FUZR2DHhk45v8d80YTCBjUHyWX+KF4uA8+t1SepNOwqYdep8GoghhE0SIkAr7jWd4IT72y7ZWfateU9iPEGd9P8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789598606; c=relaxed/simple;
	bh=SJqE2m61PGfreD5RH9QiosfZEfJfLRRLLr6K6HnsFZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bR/6dM7HpugeYqZv4Mec4nj069UtlYwmZw2Unq3WqQd+8lgjzShZkR83Y2l1eV8YInofJkTWNp6X/u0LLo8Y4kaC5RO85d7iv8feeE/8JccTezIiQtZpJ3S3bhlbLZCP3qxFbjQSswEdLiQ5pPZXs7QPDG1y/S+kGxslIv/3I5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIhkOJru; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIhkOJru"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4aaf2ecfso167325d50.1
        for <linux-modules@vger.kernel.org>; Wed, 16 Sep 2026 15:43:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789598594; cv=none;
        d=google.com; s=arc-20260327;
        b=SJsFas2JyIVtjTPOah0VQ1Hp0hGbS+UUNKY6IRdj4JaNeqR7iIHAT5FRsJMnC4aV7k
         grwr/3FL1YV4SWv69XoXtjBh+sp3MARD5/FpB74GQrHOFy2i7+vuliYKOxj4C+C7cAyp
         3C5j4TlOiyo3k06FQfyAvYX+x5/qYnnp2+s4zL1lotjULvPbdnw7I2l39AP1OVBgO3Wo
         A+ApOm9qtixO1seakHslClIYK3ELCgWgT0oBaV2J0+3dq0KdVV/woh4fR3n0ogfRcUf7
         57QphqF6f7TtDnukbQPl1JDuzAxSVsJeayrIeRKgY/DU7hfIyT9eYeSSIgxtrdiIKwLz
         CAzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VP1gHgdIqBe+kEh6BoRGZQA0vXfJ71qE3TipRKbKn80=;
        fh=pULzQsmNN9YzwFbBK82QiOWybJAa3qfa46N2yzWLqH0=;
        b=QLanGnxNFJQPkfL7mE19QhFIGXkCoGmfg4FDa+X/e0sB/WC3lGsPPD1Alp3VMaz0Km
         DKstehujvJB/AVWFTf5XXuWgaJUl4r/ii2KYwemIc9TVsqwLOCBtF8fH6KfEcYwze1pO
         ZAN7L/Il3b45uSNGTQGDxg0vFgT3f1sn6cgl/htuKhWq4QIkisIU4771OHnBhF3ewrOv
         0pb15RGmsIBCpXKJMLGGMUuPDDigmhdOkGS4S8O5dnSMtr+ZGZ7io27tvUl/m7lnlCMH
         T4prAa75gY/dxO4YbZ44JvO7kChV4LFqXqV8aH/+eijnoPmY+LYT6EnxH1JBXf5sNEvP
         dWIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789598594; x=1790203394; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VP1gHgdIqBe+kEh6BoRGZQA0vXfJ71qE3TipRKbKn80=;
        b=SIhkOJruiLdMC/Wn5Aa+0nnm1dc0AXFYRCrs7MpSTUdQ8UsXagBisCykONjiIq2C95
         fMi56SpNtXwS4YNGqoThOPegAXSyjU1WGAgiggSb0YOMPWG7FSIAVY+pVig89/Es5kVR
         nuWT2mYvg0L7g2UQkfHuaGyQsCUG2lSQRgUDrLd0QL78qFyt1HjjJrLOjEdIv7I2avaw
         hpC2kyquo/HGcX+4u25CG31W3+AWPvLRzf2+9FdSm7pQk+1ssP5i18sRQWBrptiJMhvE
         pItqz1746GecejCDXddbTffeSDe6nlhkGMwRRopXYTiPphLDhBcOhPmligYlcerXgowj
         Kqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789598594; x=1790203394;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VP1gHgdIqBe+kEh6BoRGZQA0vXfJ71qE3TipRKbKn80=;
        b=1vhedqcCPQ9md55jvRAbAeXYdQSnrq29u7SL9VWy6L1S0i9h3EWH3UbLjkfaxOoJ6C
         Szqf8dM2d/ZE0Zpr7S9RMiOSCmjL+AJSfdie3tvTM0BUOvPC/xzU6FfrIcSmdbsXOutv
         iYMGsiOOGYyfBgrY+YXx2AavyPZJTTelYwdu7bpYV3pD864e3lIaxcAtgFC/AgC1i0j4
         9xmAID4WYtGjZOzne/8973EHHkUqd36Fyl4spZqmXvF9Ul3fMqdti5HAmAvvzpGnih4b
         A1O6B320UhpSoC0RizoNCwU9YY10NdGfdPCPOQ4hP9/ECC4SYfooeaCY5HkX6o5DkP+X
         sXuw==
X-Forwarded-Encrypted: i=1; AKwUvBySPqog9dLIv3IM4LKBQ5AugVYyDqh0BWsTT3gj0s0AKkiYMRqFnbA6glYTk7sdc5bbgd3TsGjNquFLke4q@vger.kernel.org
X-Gm-Message-State: AFuF++kqkXQnP2kHsi/iSd0iyqNGP8Y1en/mZwUkkGKwNRVMGhCupLeV
	3KXrF+m+PgWyumtmQXC/pGO5JuzybI/3lPmy51YeKSYm4zscjIiLgecJCKKejy+x5C+8qvR669d
	meYFkz2534xVxO78k86HkgRMkTjmPR6scbeeGATs=
X-Gm-Gg: AYBFou3b3dPRjr52vcUV4t72ZpTk+jwtEV9/uk4Bw6/Ri1BgiLuqk9wxuIzgr1QCIwo
	E1JZnms5ux+8tEQcUP7o0i3TpMHzJ9WjAF+B7S1y/p/u+zfP7QsLYFRyGHQLnxjHV1db+oouiCd
	y3ZqBs94uZtTew5YHclvnwbJUFsWyMblUaolLHrt9Wqthm6nS8fvCwPygHa/MXJiomqYKMhQ0Cq
	ALdxg03c37eL/PDtIGddFC5cSuPD4YBSd/o70tyRx6a1BifziSOrP6t04OtEiejWd7y6nv7dmML
	BkLIdgBaOESTY5uLKHpmU4wzdeCK93qv/prZnIGEUXKpqlzgrOJhZKwKnzkNi6iEzWFEPCXQbxG
	SZi/8XcOUsutAewNXCuzA480dyBn7IF6ziw==
X-Received: by 2002:a05:690e:12cf:b0:671:23cc:8561 with SMTP id
 956f58d0204a3-67163201b32mr1574386d50.31.1789598594536; Wed, 16 Sep 2026
 15:43:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916-dd-cmap-part2-clean-v10-0-af4cf4767707@gmail.com>
 <20260916-dd-cmap-part2-clean-v10-8-af4cf4767707@gmail.com> <20260916160018.DC5F61F000FF@smtp.kernel.org>
In-Reply-To: <20260916160018.DC5F61F000FF@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Wed, 16 Sep 2026 16:42:48 -0600
X-Gm-Features: AcwNN1WFvT--q4ESZQXCY7SHYNMTMZrDrc-ogrmqFQnSBAonjPHMrZUlFUTsghI
Message-ID: <CAJfuBxzygOtC5DRjiioX3EN_pc_33dt9diNtoW7G3KiMqy_edg@mail.gmail.com>
Subject: Re: [PATCH v10 08/38] dyndbg: add stub macro for DECLARE_DYNDBG_CLASSMAP
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 10:00=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] drm: compilation failure due to DECLARE_DYNDBG_CLASSMAP stub
> --
>
> commit 96b109d4ffa1bfc809c49d548861d8dd8aa48aaf
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> dyndbg: add stub macro for DECLARE_DYNDBG_CLASSMAP
>
> This commit moves the DECLARE_DYNDBG_CLASSMAP macro definition inside the
> DYNAMIC_DEBUG ifdef block. It also adds an empty stub macro for builds
> without dynamic debug enabled to provide a cleaner starting point for
> future changes.
>
> > diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debu=
g.h
> > index 05743900a1169..a10adac8e8f00 100644
> > --- a/include/linux/dynamic_debug.h
> > +++ b/include/linux/dynamic_debug.h
> [ ... ]
> > @@ -314,6 +314,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor=
,
> >
> >  #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)
> >  #define DYNAMIC_DEBUG_BRANCH(descriptor) false
> > +#define DECLARE_DYNDBG_CLASSMAP(...)
>
> [Severity: Low]
> Does this empty stub lead to a compilation failure in the DRM subsystem?
>
> In drivers/gpu/drm/Makefile, CFLAGS is used but ignored by Kbuild for
> subdirectories, meaning DYNAMIC_DEBUG_MODULE is never actually defined
> for the DRM subsystem. Before this patch, DECLARE_DYNDBG_CLASSMAP was
> defined unconditionally, which masked the Kbuild typo.
>
> When CONFIG_DYNAMIC_DEBUG=3Dn, CONFIG_DYNAMIC_DEBUG_CORE=3Dy, and
> CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dy, this empty stub is used because
> DYNAMIC_DEBUG_MODULE is undefined. This causes DECLARE_DYNDBG_CLASSMAP
> to expand to nothing.
>

CONFIG_DRM_USE_DYNAMIC_DEBUG is currently marked BROKEN
so its not happening accidentally,

And the following is guarded by #ifdef, so it wouldnt happen

> As a result, drm_print.c attempts to reference the undeclared
> drm_debug_classes variable, causing a build regression:
>
> drivers/gpu/drm/drm_print.c:drm_debug_bitmap() {
>     ...
>     .map =3D &drm_debug_classes,
>     ...
> }
>
> Would it be possible to handle the stub expansion differently or update
> the DRM Makefile to use ccflags-y instead?
>

that patch has been sent before (by me and others), it hasnt been picked up=
.
I will send a full set separately,
insisting on it here is cart-before-horse


> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-dd-cmap-=
part2-clean-v10-0-af4cf4767707@gmail.com?part=3D8
