Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23814F4745
	for <linux-modules@vger.kernel.org>; Fri, 25 Sep 2026 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790368287; cv=pass; b=HgZ3+nwN+sdA9oyhWY3ikd7tH60VvVjyQsgnQayEdTV85zg0wFSJYjgM3ech/S4z3bRYfvaOsJYHvUuzNvQYnzJ7ObmDvaUG0v+so09BHquf80r4zVm4OjbVYiHmNHqIXtENPY4RbC0WZCpwTcCwM+PL5hgyNtucRxgaMImGfsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790368287; c=relaxed/simple;
	bh=i8K2V7iauqRYBnywpRsfGwdqYCZfWv4UWx7sJDax4N8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2XnTbfLaiKR/uuFOuDbOP47kuk5HE42GoVaR3XFZHbXimS2lqaE3MSCOFgGWH+Hk5ZwjZgzhjHw2EuSMFkfcLYoCmV7K8V5UMpfj5tF7BdWLKjh6bGiPpYnB3ycUJ5vB8sZFl2ACaQmzuVhSfsKXi//bVOKLNSpTaEdOk7WUMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjpNXmLz; arc=pass smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjpNXmLz"
Received: by mail-yx2-f41.google.com with SMTP id 956f58d0204a3-67409747ac3so1172363d50.3
        for <linux-modules@vger.kernel.org>; Fri, 25 Sep 2026 13:31:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790368282; cv=none;
        d=google.com; s=arc-20260327;
        b=bGMVOolf14ezS7NWhPqL4H+yu3NC/idJbuysfsYLpxV7fqrHox40V3pcqNCtoa/Y2t
         Vqbgh2EPGmiiG6IYIn0tG5/mot+bh4mvF/0M3DsNtilO00J9swLMQd2HL7WQ7Egpra5n
         A9DKMdGzCzv4ny3ZiQZ1nA0EGdqUNvwvEwdS91BNulzi+srzD2HNfRJHdO2iBm6RCQxy
         zDp72cRkwRVif79MHeTYJ2t6yd6xA9VprkfdM1OJWi5X9mVk8h+Si1JwsqL7zLkEj2Nb
         xg81X1fbuLM02WRxEE8sPj4nO+dFQMBd8E8ttXcLYiJqC7B1iHZXFLknvhDFaBt5bl+J
         K1Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=noxPgsc3ymzPUXdD7j20u0RQJiwVbYzVMSbEnyT4ByQ=;
        fh=4n3ZQTMOc6udBduFOoaip/HNtur9HMiv7WwDcOA5HJU=;
        b=pRu2+QfJw09vMk/aST8hD437XRcbwA75M3gTt1dg491mG3hLTG804KORlEjUSxq/v6
         VJDOjLf54ZTN83D8UoYeTO5xfRPzB4zt+lE+jvdFdi5s/okKwDpTRIr4UExLUp7mVyqL
         MEtvpaWGbu2/OKzBkfX7K8dw6+O+kHzkB508pDdguyRqt12ePCjFRxsR22Cot1IptkWb
         0htkDir4Qlp6gO+DG1wxxgC6tVOste8QxOJ7GOYNuM09e4r76rB4C3s0WgtPLqhPeMUC
         MvfkH6fhAoiOK2Szb1TsYSKOZucs/mHEqneiZYbwZpdh3WUovAs8/0+GNKrKugvZj+wH
         FtPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790368282; x=1790973082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=noxPgsc3ymzPUXdD7j20u0RQJiwVbYzVMSbEnyT4ByQ=;
        b=TjpNXmLzBaIdJEpWXZQ+rE33LSI7Ijg4oqvYvQ8zcO1X4TIybbM9R7tW+Rx6PJ94e6
         VL9xrMXYP5AoQ+b2+Lvexr8ZUqvzm5VAO32nn5LsfFgf7KyxWMiL3fwwKV2VAF44BJ25
         /3ZuVluFlCo490TVbBuLDq0x7fEwGBek7zym35Z9sHhXJ9/aIGj0NNK5WaxUMLABOtuy
         PaTWKoHMvq8svAdwg2t14P+TNeADlcXCbREq4dN0mDj/eq7kE8QdAwzMSbdAT13vDivf
         VrMILSLZSdZiBeMumuRGXPqK2VGB8kzp4kE3GIGtqSkT407KGvLiHAm/oVl/92qqPuzP
         cVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790368282; x=1790973082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=noxPgsc3ymzPUXdD7j20u0RQJiwVbYzVMSbEnyT4ByQ=;
        b=J3/8kCIf+wjhdqr5xermJdiewQuB0QdIvrnGDSRfANJPhR0g8LaaTziOuro4N78Wvc
         UYMh2kbSdBK4ZIoYQcq6RzF9wifxkfFh6BifATgBRtan0bY4rM0Ve38R9xBGgSQTkqtr
         ic9CRQBwkg9U1fO0oxMxDEfVIE/aicbSc+80dbq81NtmlyxD79CfLzA4hictrJmkmA8z
         Nd+ViJ3866q8AZ+wVmbaAJb7nRbB2VKHH4zsPncp0j+nr0RqmzXTHs+sJYl+mxOHO9q5
         HUBMf7B884woMTi3ABH0sedzgmf2RKe5KYJ2kIASYqupJ971+rq0fhAx4VukyXJss4WB
         jXYw==
X-Forwarded-Encrypted: i=1; AKwUvBwhGyqlCDP3Q2/4nKvfINd4lxsY5LXz5aumkWVL91LNK+CeX5+jwS+TYNkIHmul8Hk+eN7cQ5v8qLcDuvcc@vger.kernel.org
X-Gm-Message-State: AFuF++lry9LoLKEPyJSWV0SHsVoXPCHM/rdrGoDtS8XhzuEB9ZFINuZW
	Rgr765IxaxMqfU3GRxn4+AJYCgjWAPwrcoWwXQutKlE9aYVhG5x8lHEifMsVkxwsh7q6LmkNTpn
	P7Fx47f0q5pjNP8reQl2VKa2s7zTe81Q=
X-Gm-Gg: AYBFou1p0T6rz5sk6DgG/zrQINXGYZvhsHDrU7LZFisehkMLXZlpnnOKZLvgYNGZsGP
	ZCYh0Ps8Pk6ZDqkxFzwzKEpuYwfa8c/9qHiFF4QLkcTYfn51Lnowg0XXAV1GcSmLjbeAlk05j/o
	uI59q+42PmiD78AwkP7n1mkiPMvPuuEIw+uHBFASDvCgO0eIhFUmoAgV7eZTk6JFuLvwwv18p/D
	anrG7jH7EDA3TtmjcWD+Y6ML28AIqqXrdOobu4LXUBKt4u4I6og6Qj1rS+Tjd8/0EOEOrSHL3wQ
	XKbY9DHn1ehm3V9aLRQnXj+itj/aTp81gf2+93jkaL8bUIA2QgA8PN6I2NiQ4tI2GS3VqNdSpR0
	QxYRoSsfkpze4x8BAO723f/7Azywmb+YogA==
X-Received: by 2002:a05:690e:1382:b0:672:a289:7b0 with SMTP id
 956f58d0204a3-672ed93a88emr3463724d50.76.1790368282266; Fri, 25 Sep 2026
 13:31:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com> <20260923155339.bdc677e8e688611bcf190ad9@linux-foundation.org>
In-Reply-To: <20260923155339.bdc677e8e688611bcf190ad9@linux-foundation.org>
From: jim.cromie@gmail.com
Date: Fri, 25 Sep 2026 14:30:54 -0600
X-Gm-Features: AclHuK81aQy7pcphOyoCN0Cv4efDR1k93Uxkj909m52hc-_PgnQGdKhUE2sknH8
Message-ID: <CAJfuBxxd8hMf0OcnOK+w-QyizaKY=WA4VL+fyoD3y6EsHW1+og@mail.gmail.com>
Subject: Re: [PATCH v11 00/38] dyndbg: Fix classmaps API for subsystems, query
 extensions, selftests
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@net.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
	Louis Chauvet <louis.chauvet@bootlin.com>, Philipp Hahn <phahn-oss@avm.de>, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 4:53=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 23 Sep 2026 16:34:24 -0600 Jim Cromie <jim.cromie@gmail.com> wrot=
e:
>
> > The drm subsystem has *lots* of debug statements, in 11 categories:
> >
> >  $> git grep '\w*_dbg' drivers/gpu/drm/ | wc
> >    5663   30159  542864
>
> Methinks this regexp was overly promiscuous, but point taken.
>
> >  $> git grep 'DRM_DEBUG\w*' drivers/gpu/drm/ | wc
> >    2206   12834  202332
> >
> > All of these are bit-tests on __drm_debug, exposed to users as
> > /sys/module/drm/parameters/debug. Many of these are done often;
> > vblank is done ~100/sec for some displays. Over the uptime of many
> > boxes, this is a lot of cpu cycles on bits that are almost always off.
>
> A __test_bit (or |) every 10ms sounds quite negligible?
>
> Especially if __drm_debug is __read_mostly.  Which it isn't, afaict.
> Um, low-hanging fruit?
>

__drm_debug certainly qualifies.
I will send the patch, separately.

patch 37 adds a +c flag, to count invocations of flagged callsites
it counted 5M calls in 60 sec.  or 83 KHz.
That seems "fast-ish" at least,
perhaps worthy of a static-key over a __read_mostly



> > Dynamic-debug excels at replacing such tests with NOOPs (via static
> > keys). Classmaps was devised to bring that 0-off-cost to drm's
> > categories.
> >
> > Classmaps-v1 went into the kernel in Sept 2022, in 2 chunks:
> >   b7b4eebdba7b..6ea3bf466ac6    # core dyndbg changes
> >   0406faf25fb1..ee7d633f2dfb    # drm adoption
> >
> > Sadly DRM-CI found a regression during init with drm.debug=3D<initval>;
> > the static-keys underneath the drm-dbgs in drm.ko got enabled, but
> > those in drivers & helpers did not.
> >
> > So in Feb 2023, it got pulled:
> > commit bb2ff6c27bc9 ("drm: Disable dynamic debug as broken")
> >
> > Root Problem:
> >
> > DECLARE_DYNDBG_CLASSMAP defined the classmap, but its repeated use in
> > both core and drivers violated a K&R rule "define once, refer
> > afterwards". This flaw resulted in a regression; with drm.debug=3D0xFF
> > boot arg, drm-core got enabled, but drivers/helpers did not.
> >
> > This patchset replaces DECLARE_DYNDBG_CLASSMAP with:
> > - DYNAMIC_DEBUG_CLASSMAP_DEFINE (invoked once in the exporting module)
> > - DYNAMIC_DEBUG_CLASSMAP_USE (invoked repeatedly in drivers & helpers)
> >
> > _DEFINE exports the classmap it creates (in drm.ko), and other modules
> > _USE the classmap. The _USE adds a record referencing the _DEFINEd (&
> > exported) classmap in a 2nd __dyndbg_class_users section.
> >
> > At modprobe, dyndbg scans the new section after __dyndbg_class_maps,
> > follows the linkage to the _DEFINEr module, finds the (optional)
> > kernel-param controlling the classmap, examines its drm.debug=3D<initva=
l>,
> > and applies it to the module being initialized.
> >
> > To recapitulate the multi-module problem wo DRM involvement, we add:
> >
> > - tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh:
> >   Alters pr_debugs in builtins and test modules,
> >   checks results against checksums of expected results
> >
> > - lib/test_dynamic_debug.c & test_dynamic_debug_submod.c:
> >   Builds parent & _submod modules with _DEFINE and _USE inside #if/#els=
e
> >   blocks, reproducing the 2-module scenario under selftests.
>
> So what I'm understanding is that this series presently has no effect
> upon DRM?

I have 2-3 DRM adaptation patches,
then a single 1-liner patch per driver,
to get DRM using the new API.

39 patches seemed big enough for now,
if you'd like the rest tacked on, Im happy to do so.


> What subsystems *does* it affect?



>
> Sashiko had quite a bit to say.  It hasn't quite completed at present.
>         https://sashiko.dev/#/patchset/20260923-dd-cmap-part2-clean-v11-0=
-9b6c217fdf2f@gmail.com
