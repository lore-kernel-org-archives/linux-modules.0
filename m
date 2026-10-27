Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793060149;
	b=DKWfGhc/rpF/y1YzLzPiWp5EtV21r3SHp7m1Joo6VurkkXY5313IY9WE+B8wIeoI+N08
	 VG1wtXgZit0KaN+oTPgJEP6EZpyV6ZgDBWnogpWFww0hxu/Kr0WDmfmPmMVIAmIRdiVua
	 K2oi3wbULZdfiuH6Xem8Kgk00Pgwz8ZpcAfs/lU19J2fq48dh2IiU+3q8m3+QnYUuV037
	 apkJd9mhSKFi5zUtgjzM3Pwj6loP84PJlwQoBd1+W7nLULVKVdxd1NYzcIFVTpJ4hKLWO
	 /3Wk+7Krz1lttS+7B6vgKCcUKoCefaaSsPSSl2iBRRWcLNi+q/FZFgUxhbiOTU3hyhQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060149;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qKeQmKdHS147YBCUhe6/TQHxqYO/kgxJinnL8fZRSJA=;
	b=OKC0S0K+F5CSwkz6Xqe3o+rGgj+0NboRumQAy8yTIW9EQq+QmVuuZbfqOWhxKmpDNHMZ
	 HiE53zrivMg0rMKOb+DheoB4gwO6AKDvEck6YNEQSmepcEXb3ZegjINogt44H/LRligU4
	 eyJlKzXzjY7oJvc0phCW2+wYBXvlNJDqna35I2Pc0NpAigC0mrpd8mhXTWM6IoAqCjQ8w
	 s4zfj4YV5LjfQW7TmrD1tiUaG40+G6tO/exjNdFdoB/WB018Hp1DPA3c3bNstnz1w4FBw
	 LLE5ihnZ5B/p2lZYq3eaT7pM9CvVd+r9mRuFyk99GeELcAfhMWZeLXZ+pJ/f/O/Qxmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s0Wfg3DQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5B4606A326
	for <linux-modules@vger.kernel.org>; Tue, 27 Oct 2026 00:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F5B4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s0Wfg3DQ
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8aea7b7ca0cso29153357b3.2
        for <linux-modules@vger.kernel.org>; Mon, 26 Oct 2026 17:15:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793060148; cv=none;
        d=google.com; s=arc-20260327;
        b=Qb6irK4YjzernJXwcwyuhk3a70SIbL8ylfivzKxEKZndFYHwAuIC6bQ9KjKE74gvXx
         3DF39HOxirIwy1qKzpLP++TCO/Pzfg66OwVHwGk4u8ELqrqmdVc/FqBo6kckAa3w5JsC
         7wVc/AmaoFdvE9nCq29pD/3KNYDsy8YtUqxMgtuOYHVDQ7iBPPzAAHaj5tUoYmgOZ+cR
         6Ef0gOhDmVGPZZS96sCPLnETS44OHTKxQ3X0ArwzJ+QnsUPU8wjLIFmCAiftMUSNYqSo
         4b5SrD1Y+8LwVr74bWDIO9fROGUckNV7KxPnYrTmXJCIx/mtIRs2Bz4oSmWAw44w0cEx
         CrHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qKeQmKdHS147YBCUhe6/TQHxqYO/kgxJinnL8fZRSJA=;
        fh=HyzP9U9n1fLUbgcFWFOoPNqCe3eFxg4c50ltzg2xbTg=;
        b=JvzyWduxt/bgMMVa7v7jpHsLxVHH3OO74a3aGx9o/SoE4zICLZ1ouH7YlzwsnFSHji
         pP2s6O1oO2PmqK8X/HOjVwBHGpo3N8p6iTYNkoH4D+Wcjg1scCyNRrntEMf1kaeqSHGe
         9mNsmxIwPLTgGs3F06VZv4mTH5M1cH7ZuFMBpc+fXiSI95Qvomga2rk5t2zSozDPtGOH
         sa//Dw6POCVxeCYS2eN85Fmp75QCs/16kI8yyR/3uAdap0469fQ0zsT44j4y3HmSerTY
         yOvyOyVMdoinuGXHXw8SfL3h2emnr0cAcxvTCpMK9P6U4sxl4u/tw1Zfu5GJKKjOlyAz
         /1uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793060148; x=1793664948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qKeQmKdHS147YBCUhe6/TQHxqYO/kgxJinnL8fZRSJA=;
        b=s0Wfg3DQSfdPBtgTrPJ7hEq4HUweU0fxNhhrERYXULKUVGjvojByBZj8KKVt7nRxU+
         qfuMSheIJo5HVMHmH35pJ0m4FosgwDQvoFqO6hWdyPRkiWPWjpgGD4+44lYarYwcj4p9
         lwGrCp9TiIJ7Y9Q7o3VLX5IDHtJph2ZfYWK9hb7nwFZcN/EGzSOwKwJdiqW4e4tKM19a
         TwcHswoqbtz3QUq2JqUArNS2ontBIM0U5Az1Xxt/qvNOY6jlotL5RVH54V4eQYaO9/UJ
         cfXBJNeZLYP/7FfHZRk1FnPXiW2XAqkAAz+W61A369XeoogwEs/6FcBTuT08s5U96hTP
         UsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793060148; x=1793664948;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qKeQmKdHS147YBCUhe6/TQHxqYO/kgxJinnL8fZRSJA=;
        b=VtdqNxFWM2pQDg6rvGkpzCN5PGBpkrFbRJEJk3TvhlOM5fhAso2Gb/p0W2EK3tFjna
         iWvCnCsp95CKho++U4aZLRfyaYXv/ApE8h8LvTiOkbnZgt80uU0wcCsoQfYtV0gwufir
         qdswIxH9P9LZAQng2lCVoarfu99g/OrcrfsBfc0YD3yBuEGKui7B0+9x+jWuqAHCNOkH
         fwPwXSX+2FIptZmULM+YN4atA0ir5De03WIHGBRuZkVJ359eoLHcg/QdcwqKh+NRap94
         oXmBzlk8v89yytbMn4p48oIVX0Iw/LZhdoLTaQf3Xj/BEFeeI9G0KC8oo3SSGMU4aZLP
         cvmg==
X-Forwarded-Encrypted: i=1; AKwUvBxbesrp3KtEl3mSRoL0ur5hxfdsjVWawauLuO2wXoEuW6wg5IjyoD/UVnh+NHjeGXSsw9Xa52keItSiFyQ2@vger.kernel.org
X-Gm-Message-State: AFq9FYL6jvffQRWskeyZmls9Matp92BYHZxtxLmSv68FywZfdarkEdD1
	oHf0JKkR+gdmX/kytH1w3zHt5HL9cuHBI5TcajZyPlWAHGDjmpeH97gVlYLqTVKET9QAN7d6xTL
	+6173wy0rE/6/Q1Zp7rVx1wm7xvnl+Sc=
X-Gm-Gg: AYBFou0xsHBTYS+3+aimUthZX7huuxdgIDOtwoAaAWxDXVGGr/cghfQlVsn35VfEQVa
	SmNmC+wfW5w6SBWk0M+IPojIMMi9nOhypt6HtxtqoG7DD36LN7+Pm4pYuWTohNSUvTmea6WZ1N5
	0qzReAPyWWox6+76KgTV9bcG0gxg/8+KnQiD1L1ykbT8fPW+qqPozaoes/biIhGN+LpFTzba6rO
	zoDrDFLIRClyBHsOrCpiOHNNcI5mhR24RsLAYbdfTgNtTyZdKShTZ6MN1JmHCJEPMwj7DYecG+q
	yROChVDGGR4mH2BoBJWtu8TQg1K89K+Zc2agjscLxLUIphwtTrEw4r9CrZFMEGmSET3CHOfSZck
	gId7vOrFiE/VtEh8m79a8quCgS56e7LIXXFyXvuyW/AyplsMbtNeBRwNOJs56Lz759/Qx63QzSd
	uMy3dGq8lmS+MlweU=
X-Received: by 2002:a05:690e:150f:b0:679:c803:98d1 with SMTP id
 956f58d0204a3-67a45496c6cmr4080476d50.152.1793060148265; Mon, 26 Oct 2026
 17:15:48 -0700 (PDT)
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
 <20261012-dd-cmap-part2-clean-v12-33-3c8cc5725def@gmail.com> <as4W9hToBqAvbzJ-@pathway.suse.cz>
In-Reply-To: <as4W9hToBqAvbzJ-@pathway.suse.cz>
From: jim.cromie@gmail.com
Date: Mon, 26 Oct 2026 18:15:21 -0600
X-Gm-Features: AclHuK9LH_u23sCYiYKMz0I-9md-phfbwb6JA9KZbhXjHlVRGYmTapsg8H2JBYc
Message-ID: <CAJfuBxw-cq3AYXKZ07Y3732tDM-NYxt+rs8Fz6S=P7+1TF5WNA@mail.gmail.com>
Subject: Re: [PATCH v12 33/40] dyndbg: Ignore additional arguments from pr_fmt
To: Petr Mladek <pmladek@suse.com>
Cc: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
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

On Tue, Oct 13, 2026 at 5:33=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Mon 2026-10-12 20:37:04, Jim Cromie via B4 Relay wrote:
> > From: Philipp Hahn <phahn-oss@avm.de>
> >
> > pr_fmt can be used to add a common prefix to any output from a module:
> >       #define pr_fmt(fmt) KBUILD_MODNAME ".%s " fmt, __func__
> >
> > But adding additional arguments breaks dynamic debug:
> > > error: macro "DEFINE_DYNAMIC_DEBUG_METADATA_CLS" passed 4 arguments, =
but takes just 3
> > > |         pr_debug_ratelimited("%s", "Hello world!");
> > > |                                                  ^
> > > note: macro "DEFINE_DYNAMIC_DEBUG_METADATA_CLS" defined here
> > > | #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)       \
> > > |
> > > error: =E2=80=98DEFINE_DYNAMIC_DEBUG_METADATA_CLS=E2=80=99 undeclared=
 (first use in this function)
> > > |         DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT=
, fmt)
> > > |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> I wonder what this error about undeclared macro means.
>
> > > note: in expansion of macro =E2=80=98DEFINE_DYNAMIC_DEBUG_METADATA=E2=
=80=99
> > > |         DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, pr_fmt(fmt));    =
     \
> > > |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > note: in expansion of macro =E2=80=98pr_debug_ratelimited=E2=80=99
> > > |         pr_debug_ratelimited("%s", "Hello world!");
> > > |         ^~~~~~~~~~~~~~~~~~~~
> >
> > Add an additional ', ...' to DEFINE_DYNAMIC_DEBUG_METADATA_CLS to slurp
> > any additional argument, which `pr_fmt` might add.
> >
> > --- a/include/linux/dynamic_debug.h
> > +++ b/include/linux/dynamic_debug.h
> > @@ -351,7 +351,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor=
,
> >               dump_stack();                                   \
> >  }
> >
> > -#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)    \
> > +#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt, ...)       \
> >       static struct _ddebug  __aligned(8)                     \
> >       __section("__dyndbg_descs") name =3D {                    \
> >               .modname =3D KBUILD_MODNAME,                      \
> > diff --git a/include/linux/printk.h b/include/linux/printk.h
> > index f594c1266bfd..5d701952e739 100644
> > --- a/include/linux/printk.h
> > +++ b/include/linux/printk.h
> > @@ -742,7 +742,7 @@ do {                                               =
                       \
> >       static DEFINE_RATELIMIT_STATE(_rs,                              \
> >                                     DEFAULT_RATELIMIT_INTERVAL,       \
> >                                     DEFAULT_RATELIMIT_BURST);         \
> > -     DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, pr_fmt(fmt));         \
> > +     DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);         \
>
> IMHO, this changes the existing behavior. The prefix added by
> pr_fmt() will no longer be stored in DEFINE_DYNAMIC_DEBUG_METADATA().
> Is this intentional, please?
>

yes, its intentional.

515a9adce0f0 ("include/linux/printk.h: include pr_fmt in pr_debug_ratelimit=
ed")
added pr-fmt to both the METADATA macro call, and to the printk() just belo=
w it.
The commit-msg was clearly about adding it to the __dynamic_pr_debug() itse=
lf,
the METADATA addition was overzealous.

Removing it brings pr_debug_ratelimited() into conformance with the other
*_pr_debug_* calls:
    dynamic_pr_debug, dev_dbg_ratelimited, net_dbg_ratelimited.

and as you noted, this makes the ... variadic unnecessary.

Ive added the Fixes: tag accordingly.

thanks for the review & pushback.
and apologies for the delay, I picked up a FLU shortly after sending v12.




> Anyway, if we do not longer pass pr_fmt(fmt) then we should not
> need to add "..." into DEFINE_DYNAMIC_DEBUG_METADATA_CLS().
>
> By other words, we newly pass just the format "fmt" without the parametes=
.
> The 4th parameter was added by pr_fmt().
>
>
> IMHO, the right solution is to keep pr_fmt(fmt) here and extend both
> BEFINE_DYNAMIC_DEBUG_METADATA() and
> DEFINE_DYNAMIC_DEBUG_METADATA_CLS()
> to accept var args. I would expect something like:
>
> #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt, ...)  \
> ...
>
> #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt, ...)           \
>         DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT, fmt,=
 ##__VA_ARGS__)
>
>
> or maybe, we could "eat" the extra parameters in
> DEFINE_DYNAMIC_DEBUG_METADATA. It would mean to keep
> DEFINE_DYNAMIC_DEBUG_METADATA_CLS() as is and just add the "..." into
> DEFINE_DYNAMIC_DEBUG_METADATA(), aka
>
> #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt, ...)           \
>         DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT, fmt)
>
>
> Or do I miss something, please?
>
> It is possible that the macros work another way. Or this depends
> on another change. I checked only this patch...
>
> Best Regards,
> Petr
>
> PS: I was curious what Sashiko says about this change and it seems
>     that it does not review this patchset from some reasons.

I checked shortly after sending, it was "embargoed" for 24 hrs,
perhaps cuz it was so soon after rc7

>
> >       if (DYNAMIC_DEBUG_BRANCH(descriptor) &&                         \
> >           __ratelimit(&_rs))                                          \
> >               __dynamic_pr_debug(&descriptor, pr_fmt(fmt), ##__VA_ARGS_=
_);    \
