Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793211814;
	b=SsFyT8hqIFi+mFYieXjaET4R/FJNJNnPCF1fDOArAD/H/32yLQY73MPEDuP2zDx3SdZU
	 dMNtXRPuHhizmYxiJ3wmeeHmRU8/Q/H+V6Tl+/g8s6ELVa3vSJsOIath/IykQXouoJBzd
	 kdHHQSkEocgHY+/xx8x/2EBxNOQfxlIYt9FHk1L8jstTzENRulyQ+FCb3VpOB3ROmvKf/
	 RCz29BDnmPEaEjcwsKhm7Ty1Zt5yI5ZbwwbhlvsEgkRExY9DpsVeId7dqW4eghpWffi0b
	 hqeRsm83Nf4LhGbffyzzIAyAxaS8XXrjNObzFZlvEUffftYzpet97hsuEUcKDc32ZjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793211814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cFWfkIkWfjhOSUFJOJXQEhmE0QtvF6eBs0tDviPyGsc=;
	b=JhCaJlhmgPoscix6jMrbCu1XwoGbI7A0X6TWrBE4uExZ0AcY5/ZSdbXx6rwvVJpRCRB9
	 Pm/r0hZggt4VP43RO7U8KsccqZyn7mxJW32C7Z3Iu/VLOhSp7U5/7Zp2P+UL+8/jgSiBX
	 xdiEQQLChZGZkQcZjhysq5eq1JE+WG1V3rE2lTnO9z/ZhdnwFPqTtoO9Ffz1sBfCNywYb
	 g1frBFTe1h0ZFTr8CF4NEM5OIbB2oDVSwUmuVWdqWb9QMAmrEfFTOhjl++wf8M/L3DYpv
	 02Q5xLKDUlcVtL9K9RnL8Dx5Jtqmxlt3zJYM4rt0cbWGqqJQmPmiePCe51YKXm7atVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cmCVmz5E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAA160A2600
	for <linux-modules@vger.kernel.org>; Wed, 28 Oct 2026 18:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AAA160A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cmCVmz5E
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-67999045530so1187551d50.1
        for <linux-modules@vger.kernel.org>; Wed, 28 Oct 2026 11:23:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793211813; cv=none;
        d=google.com; s=arc-20260327;
        b=pTf193gDVXUIJXxTDVLakhwyyC9Ig278GWfu1s74FDl7GFAqfgVu2A3XauzGFpmovd
         iTVAQSYEebyM2958HX4DC+nw5St+yWsWXMRWUy8fLWz98vxfY2mCc/vEZRgMugIf+B7n
         l2V8v1LwEVEJd+U8FLwScTzN8FaA340POXRNaTmswn7zeipGr/zpPjB5MjWAomb3FwE2
         CC+jqhrVrdQzw+qD+hXlxSrUgwOwDOJEeGJFPOJkgBHJqlEaOJQjv6ot4bal4fX6+USG
         2hWDLZKN/MO35bhJ6h0djVz51JS7R3MY+S6vrxMqzuEh/D7dOk7yVELdcCsqC2eV+kS7
         8Jww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cFWfkIkWfjhOSUFJOJXQEhmE0QtvF6eBs0tDviPyGsc=;
        fh=Ov63A53Ymjn4uOfFYGwEJD7l5bjMHgv5yFcnTQam7Bs=;
        b=NdImYDnIkvcfIz/mUhUOKpgWWF5hNZ6WyOBO/NBDV5e1FwzttyPgK4RCOTsK0r6s47
         Xvx3Z3aft062hd54HzaCtwr6lF5Ne9h7FyfnCNuC5ABa0s0kgc8FI1NFcFkEDv9FC20H
         DozEXl0TceMQwZl2w1LTjT9MRTdpMDnWaQ5NMcZVgywV1TYGpAHS83RuF+4QaSx7CHwR
         u0T20ge3Dn5Fn9nyF9XX8IjtY4u3C94TN4ixI+1wsJtup/NV+leBlsSjIRY3zbWsEKDS
         Lyw6HVx0m2nEZr9dg5lGbJcbkzEyIaYm01Eoo8ynLEXrQ2ZGB3wjH2ZsvmodPMx+IL+u
         M9XQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793211813; x=1793816613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cFWfkIkWfjhOSUFJOJXQEhmE0QtvF6eBs0tDviPyGsc=;
        b=cmCVmz5EDlPgGpt7D48i7zZLLkqYO+wKOQEJCFw+CPT1V0HsVdAOe24mkft9RXoEkD
         jPI3A5deGmYs3Q1PF3kw8R4dQ23CEIy4/U1S9qF9Ar1JXrXInpunTdMqBudL8okCjjoy
         5f2IcaSQ8wAY9ju3+/m0NYTjPTu/ueX6EsDmnX2FcC4QUPjx2/QEKkvGtV3J6mBSoLn1
         c3+DohN62m7thFQFl0j2MU+ok2Gf6av/sgv+lltqY/+2wDnHn7XYq7irZX+hCgsbB0iP
         CA/YnvHkM7rIJBNzGlEN4RTUyMUBRGWhDff6qMJm3GQt/BHtf5zQNMIcn/yy9/Oe26Hk
         1FOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793211813; x=1793816613;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cFWfkIkWfjhOSUFJOJXQEhmE0QtvF6eBs0tDviPyGsc=;
        b=rrbmlKvgnmkS9qufrRe2cnOM57RQRIWi/Ld4D0rdTp51Qessqq8VSz0/qARgVxMtfb
         DEftQUjZoNBOjCWtJ9NoQAKWHHd/ozCvInS9qYQrNQMCOVBE7+IkGGejvQm0bkYbkBEt
         kkq/U0Zl7FHYwj5hWaYtVir/C9iS9cC3SIgP9ePqwnXbUyKV8u+J22Ac1BtCMu+VuYdR
         yOvjDPF2PiVNYoMd7MpGeFi44mi0SttPZLSt0SeiBh6fzIufSuIiZ1OkcEe4pkddn2rj
         A1So/MIe83j8Pa88ykZQsrl87BYFmJn3pUgVwy4Y5UN0C2CkjkdIdEK+85DXO5k0Mevx
         3Vcg==
X-Forwarded-Encrypted: i=1; AKwUvBxa0XOcaO1DpsBTyUB/afPk8JDWv0JLLxNK44ARl//W+/SzoSInN4GlubdIviXTnfMVW9ymbaKwgYBg64or@vger.kernel.org
X-Gm-Message-State: AFq9FYKza54cc25sX1uqXnJhYjGFh5jJX/EfeJzTSor4dSygp8nTGY7i
	dFlGFgyKBtSqR/2wLYwdIFy6213Pr5Vzx3F4TrLXuQL5JU8mMa65dC6zTHoWyZCJMpe9GgyWb0q
	worgb2fC9tXgleiy8Okv4sutb7MMO1nQ=
X-Gm-Gg: AYBFou0ZwsfPtsb4kpi7USzj5sdoCVfpowOmMtmo1DfV12Ew5THbbKR3HcMncLAvjTB
	I5wMF/JEV9iR137FG5C7F2l1o0gs/1iyT8//AlWFxb6HTAFjsb5Zf/4gJfg7DmKvBKWJXxAue+v
	ZCBhHeftgKLbMBy5JxT/xpSf3H+ZbneKpjngQptbkQPBWFRmeQLQBul/RtE6yDq8Lnm9Gp2wXFi
	iKECt5X4I4h+u2bNG+FPrxfE+N/LhKspQkeyAzmtr/xHkM2bXy7L613HnX1xhmKV9NFGnkZnU+O
	iw4IDP4WvFxh6ydyApcKtMg6kEdcVM7biRlsTDc8b40564XhPrsA8E408BKsFw1YUVi+E+rkmie
	XLFQYrTUxGNqf7YvPy9rh8hlBt9TGf516RcrCqlZV7WjltQyKTMtukPVxo8uX9Cyqg6pwznQSn+
	VOA8FLUSFTqwkUbHQ=
X-Received: by 2002:a05:690e:d0d:b0:679:9e60:346c with SMTP id
 956f58d0204a3-67a7baef0a5mr2432293d50.4.1793211813004; Wed, 28 Oct 2026
 11:23:33 -0700 (PDT)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261012-dd-cmap-part2-clean-v12-0-3c8cc5725def@gmail.com>
 <20261012-dd-cmap-part2-clean-v12-33-3c8cc5725def@gmail.com>
 <as4W9hToBqAvbzJ-@pathway.suse.cz> <20261027132253.5f3a461d@pumpkin>
In-Reply-To: <20261027132253.5f3a461d@pumpkin>
From: jim.cromie@gmail.com
Date: Wed, 28 Oct 2026 12:23:06 -0600
X-Gm-Features: AclHuK-4voxmbnvtymBlAumJXr1uxieHMHufYdWUINblBauYdwThefAV8akW3iU
Message-ID: <CAJfuBxxgn8AOv_1rrAWb1xgJiPyU0faD08RuTz4kGY9RS_-v1g@mail.gmail.com>
Subject: Re: [PATCH v12 33/40] dyndbg: Ignore additional arguments from pr_fmt
To: David Laight <david.laight.linux@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@net.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
	Philipp Hahn <phahn-oss@avm.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 7:22=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Tue, 13 Oct 2026 13:33:10 +0200
> Petr Mladek <pmladek@suse.com> wrote:
>
> > On Mon 2026-10-12 20:37:04, Jim Cromie via B4 Relay wrote:
> > > From: Philipp Hahn <phahn-oss@avm.de>
> > >
> > > pr_fmt can be used to add a common prefix to any output from a module=
:
> > >     #define pr_fmt(fmt) KBUILD_MODNAME ".%s " fmt, __func__
> > >
> > > But adding additional arguments breaks dynamic debug:
> > > > error: macro "DEFINE_DYNAMIC_DEBUG_METADATA_CLS" passed 4 arguments=
, but takes just 3
> > > > |         pr_debug_ratelimited("%s", "Hello world!");
> > > > |                                                  ^
> > > > note: macro "DEFINE_DYNAMIC_DEBUG_METADATA_CLS" defined here
> > > > | #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)       \
> > > > |
> > > > error: =E2=80=98DEFINE_DYNAMIC_DEBUG_METADATA_CLS=E2=80=99 undeclar=
ed (first use in this function)
> > > > |         DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DF=
LT, fmt)
> > > > |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > I wonder what this error about undeclared macro means.
> >
> > > > note: in expansion of macro =E2=80=98DEFINE_DYNAMIC_DEBUG_METADATA=
=E2=80=99
> > > > |         DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, pr_fmt(fmt));  =
       \
> > > > |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > note: in expansion of macro =E2=80=98pr_debug_ratelimited=E2=80=99
> > > > |         pr_debug_ratelimited("%s", "Hello world!");
> > > > |         ^~~~~~~~~~~~~~~~~~~~
> > >
> > > Add an additional ', ...' to DEFINE_DYNAMIC_DEBUG_METADATA_CLS to slu=
rp
> > > any additional argument, which `pr_fmt` might add.
> > >
> > > --- a/include/linux/dynamic_debug.h
> > > +++ b/include/linux/dynamic_debug.h
> > > @@ -351,7 +351,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descript=
or,
> > >             dump_stack();                                   \
> > >  }
> > >
> > > -#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)  \
> > > +#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt, ...)     \
> > >     static struct _ddebug  __aligned(8)                     \
> > >     __section("__dyndbg_descs") name =3D {                    \
> > >             .modname =3D KBUILD_MODNAME,                      \
> > > diff --git a/include/linux/printk.h b/include/linux/printk.h
> > > index f594c1266bfd..5d701952e739 100644
> > > --- a/include/linux/printk.h
> > > +++ b/include/linux/printk.h
> > > @@ -742,7 +742,7 @@ do {                                             =
                       \
> > >     static DEFINE_RATELIMIT_STATE(_rs,                              \
> > >                                   DEFAULT_RATELIMIT_INTERVAL,       \
> > >                                   DEFAULT_RATELIMIT_BURST);         \
> > > -   DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, pr_fmt(fmt));         \
> > > +   DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);         \
> >
> > IMHO, this changes the existing behavior. The prefix added by
> > pr_fmt() will no longer be stored in DEFINE_DYNAMIC_DEBUG_METADATA().
> > Is this intentional, please?
> >
> > Anyway, if we do not longer pass pr_fmt(fmt) then we should not
> > need to add "..." into DEFINE_DYNAMIC_DEBUG_METADATA_CLS().
> >
> > By other words, we newly pass just the format "fmt" without the paramet=
es.
> > The 4th parameter was added by pr_fmt().
> >
> >
> > IMHO, the right solution is to keep pr_fmt(fmt) here and extend both
> > BEFINE_DYNAMIC_DEBUG_METADATA() and
> > DEFINE_DYNAMIC_DEBUG_METADATA_CLS()
> > to accept var args. I would expect something like:
> >
> > #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt, ...)        \
> > ...
> >
> > #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt, ...)         \
> >       DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT, fmt,=
 ##__VA_ARGS__)
> >
> >
> > or maybe, we could "eat" the extra parameters in
> > DEFINE_DYNAMIC_DEBUG_METADATA. It would mean to keep
> > DEFINE_DYNAMIC_DEBUG_METADATA_CLS() as is and just add the "..." into
> > DEFINE_DYNAMIC_DEBUG_METADATA(), aka
> >
> > #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt, ...)         \
> >       DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT, fmt)
> >
> >
> > Or do I miss something, please?
>
> Don't think that will work.

Im not sure who youre responding to here,
in any case I sent v13, with adjustments based on Petr's observations.

here it is, in action

bash-5.3# history
    1  modprobe test_dynamic_debug dyndbg=3D+p
    2  dmesg
    3  modprobe test_dynamic_debug_submod dyndbg=3D+pmf
    4  dmesg
    5  history

[    0.707538] virtme-ng-init: initialization done
[    1.060923] clocksource: Marking clocksource tsc unstable due to
inter CPU skew
[    1.060929] clocksource: CPU0       4136478715 < CPU1
4136478900 (cycles)
[    1.060932] tsc: Marking TSC unstable due to clocksource watchdog
[    4.703188] (udev-worker) (78) used greatest stack depth: 12376 bytes le=
ft
[   44.598698] dyndbg:  47 debug prints in module test_dynamic_debug
[   44.598706] dyndbg: module: test_dynamic_debug dyndbg=3D"+p"
[   44.599208] test_dd: init start
[   44.599210] test_dd: do_classes 1 times:
[   44.599212] test_dd: doing categories
[   44.599213] test_dd: doing levels
[   44.599214] test_dd: do_bulk 1 times:
[   44.599215] test_dd: bulk msg 1.0
[   44.599216] test_dd: bulk msg 1.1
[   44.599217] test_dd: bulk msg 1.2
[   44.599219] test_dd: bulk msg 1.3
[   44.599220] test_dd: bulk msg 1.4
[   44.599221] test_dd: bulk msg 1.5
[   44.599222] test_dd: bulk msg 1.6
[   44.599223] test_dd: bulk msg 1.7
[   44.599224] test_dd: bulk msg 1.8
[   44.599225] test_dd: bulk msg 1.9
[   44.599226] test_dd: init done
[  527.233033] dyndbg:  47 debug prints in module test_dynamic_debug_submod
[  527.233039] dyndbg: module: test_dynamic_debug_submod dyndbg=3D"+pmf"
[  527.233458] test_dynamic_debug_submod:test_dynamic_debug_init:
test_dd_submod: test_dynamic_debug_init init start
[  527.233460] test_dynamic_debug_submod:do_classes: test_dd_submod:
do_classes do_classes 1 times:
[  527.233461] test_dynamic_debug_submod:do_cats: test_dd_submod:
do_cats doing categories
[  527.233463] test_dynamic_debug_submod:do_levels: test_dd_submod:
do_levels doing levels
[  527.233464] test_dynamic_debug_submod:do_bulk: test_dd_submod:
do_bulk do_bulk 1 times:
[  527.233465] test_dynamic_debug_submod:do_bulk: test_dd_submod:
do_bulk bulk msg 1.0
[  527.233467] test_dynamic_debug_submod:do_bulk: test_dd_submod:
do_bulk bulk msg 1.1
[  527.233468] test_dynamic_debug_submod:do_bulk: test_dd_submod:
do_bulk bulk msg 1.2
[  527.233469] test_dynamic_debug_submod:do_bulk: test_dd_submod:
do_bulk bulk msg 1.3
[  527.233471] test_dynamic_debug_submod:do_bulk: test_dd_submod:
do_bulk bulk msg 1.4
[  527.233472] test_dynamic_debug_submod:do_bulk: test_dd_submod:
do_bulk bulk msg 1.5
[  527.233473] test_dynamic_debug_submod:do_bulk: test_dd_submod:
do_bulk bulk msg 1.6
[  527.233475] test_dynamic_debug_submod:do_bulk: test_dd_submod:
do_bulk bulk msg 1.7
[  527.233476] test_dynamic_debug_submod:do_bulk: test_dd_submod:
do_bulk bulk msg 1.8
[  527.233477] test_dynamic_debug_submod:do_bulk: test_dd_submod:
do_bulk bulk msg 1.9
[  527.233478] test_dynamic_debug_submod:test_dynamic_debug_init:
test_dd_submod: test_dynamic_debug_init init done
bash-5.3#

NOTE that  the dynamic-prefix precedes the one added by pr_fmt,
(the parent and submod differ, latter adds __func__,
in both the dynamic-prefix, and the one from pr_fmt())
This is perhaps vaguely sub-optimal, but it has been this way for ages.

> Won't you end up with ".%s" fmt as the string without the extra argument.
> So you need to keep the expansion of pr_fmt() together until is is finall=
y
> substituted into a printf-like call.
> It is possible to enclose it in () so it is passed as one parameter and
> remove them on the final expansion.
>
> David
>

hi David,

Im not sure what / who youre responding to with "

> >
> > It is possible that the macros work another way. Or this depends
> > on another change. I checked only this patch...
> >
> > Best Regards,
> > Petr
> >
> > PS: I was curious what Sashiko says about this change and it seems
> >     that it does not review this patchset from some reasons.
> >
> > >     if (DYNAMIC_DEBUG_BRANCH(descriptor) &&                         \
> > >         __ratelimit(&_rs))                                          \
> > >             __dynamic_pr_debug(&descriptor, pr_fmt(fmt), ##__VA_ARGS_=
_);    \
> >
>
