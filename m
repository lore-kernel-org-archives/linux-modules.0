Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793053681;
	b=t87oS9Kxsx6eiJj4WR51RVy7U9f3Z/imD33NW4vBpZcXfmB/qiOra4DHMGKDI0Xr/pgY
	 shhG0LFFMGSM0X69Ua8AUErfCzmmfG6mk8/I3K9ycNzI8OWh9V+xh8+ExWQTmwqBMl4LP
	 kQ7tnY23L1/a4aMRagl+SFbNRROYfzkSw+Cv96fo7gPyDEZbVCsbNRWjTFufNQfpyHZXi
	 Dd/Id5H5VXiauDaKlBGgpqcsSxBwZqE6J74imatjT7qqJD5ceOv4IapXg379D8q7Xscw3
	 is32lwuD1zcKRjuZji9lvenwgzq+JeB56sbtoe0fXM8YnwS+3c9CmdCwhdZVzeSOr6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793053681;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=K6A7J4OpJDcLLheDWUIyyi0Xo+zxVRi79rgHbCkqBj8=;
	b=wZ+KRGHoN3HK5hxwcNI7o5AqKUG3i6yeI17SC85gdNuaQxf99Z+p/6qkaHz/Dbv3mUvM
	 retMkuQpNcRF3Xnaze+l5ZNhZAReXFwy/GP2+svW2HGeAsPDg74vK/nBPWZ0r7pbNFVfX
	 jCM36Rkg3J/ijfUhOiQ7xuQo/SWjW9j3qA8DxJCpwdcZdFqFuZEWxH88fARtheRMap+wk
	 hBtiJ7fwI4awzF0VlOD5IrCc8OkZ8+2rI3K6VrZvcdPA+KeWgyldczEQtlLku8V/nIG7r
	 BwAwAS7e1kHpZdql8ug5KLh9Y3ciGHsq7ikubJ4TglTzd/BE/bIvMX9zmggwZAKbP6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E9YBGUS7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5F8606A31E
	for <linux-modules@vger.kernel.org>; Mon, 26 Oct 2026 22:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C5F8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E9YBGUS7
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b10ac6ab7bso33185537b3.1
        for <linux-modules@vger.kernel.org>; Mon, 26 Oct 2026 15:28:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793053679; cv=none;
        d=google.com; s=arc-20260327;
        b=FSqLPYWDMsS31/3IJP99mVPwx+ruhuFiunXBGtEY3nGEnbBDp3fhya2O2SQepw1cAj
         SRGBzC6ATO9pmaM7PIJ7L1LugwnsZirX2gZbSH9RWacI97mQYV3nX1jDKkaP8OhUtLE3
         gr7OHWe9gIbJhCZ/EDfin4YLTn9yat2K5PUnnDFT76ooLc62DTjxTsVD6tUVunou8KGr
         pXumrtx8W+ptLqcX/PVs/GEFxZyakq3kornLNFNnLptqJ0R1UuYg6svNoZeK3tFJaU9Y
         3tedugHeanyVnKI25/jULxk0gTTa7DZ2ur7L0rpNWZpUtKiIa3ghBWfdbQhH07vVqrY7
         SdYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K6A7J4OpJDcLLheDWUIyyi0Xo+zxVRi79rgHbCkqBj8=;
        fh=USkcnUDy7EtJ3fEtxzc3L1ezRzGo4NV1/WZejJR5/7E=;
        b=oGPHCk0rBJx5kUVx9m2FuB8jCcDv5aCeC0eSh5YRPZgbDRU2MVwj/uX6Ov6WKxVw2i
         HKd8cwqsnXX6ZWmibmQwi/Ao17MSqXP/eHbeq9mwKhPMs/UOIYuqnX1sP0FjwPLukdBR
         N2bXco/c+jRiwyg8oJGSWtcvbvz3k6aA8cFSf9dtfLNE7gvmytsOalyJfhGpvE5HpFkG
         ITUuAx63Y8hEjwvu0KT2hiVor0QWAtz8M6Q24xJh9Jh90SONVhNi21lWAOu7K7OObHeP
         PUDmv8FD4HyEF4RqWysBFZtUpvUcR4WVQcRL36OWQ0WG9//eqVhw3irwi+cwvplbXO2B
         O95A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793053679; x=1793658479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K6A7J4OpJDcLLheDWUIyyi0Xo+zxVRi79rgHbCkqBj8=;
        b=E9YBGUS7WNBU8prH1BqAX8sJoXwUsUTQ6t6lAnB1EzdmS3eFxBlbvm876uqb+kTN5Q
         7CCxdA5OIicE+sHrIIOZzGSwEj6M0iA8rZL0DJv4qY+b8rOqGsPCY2vcbX8GP6a5AFwY
         5EpMwrXkUlvJpte0g0boeTa6QgtaiKIwPWukgDVoZwQpYmNVkP/KANXNZAhYzPu8jyHg
         FOsfS+ysqWibpN+8XXjOM5uK3SPX0c5B32nxIby+YgqHy4ARBfQvhGrnJbsbR9jqwXo5
         GD/Yi8KDmeXoc0gXy70hntIFrAu58NPR+zzfNZx9Zf3bUlPJBOVp0z7aXkx3n2s/CuaZ
         2RXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793053679; x=1793658479;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K6A7J4OpJDcLLheDWUIyyi0Xo+zxVRi79rgHbCkqBj8=;
        b=NBMRSUqsnPeLfmh+u7Mzv7PoIEQD3ZWdaH+udq9Ov2FuSHQJL4vG+Pk2JnxvWfyveY
         qFhxVvMeLEGvfCYwIZh8Ankj0Z8ueLRln3U+3VlTvBV4V5omr7O2EyY1guSiojZC3IbN
         EMXoPBlstyUokb01pAQU9rqbRZs7BBCQuSsAeWevny+tX+4fVmXi8GsmA6w1L3PQpuoy
         uogkt4Ja0msRcK8BBie2Jc7/tMIy0widswSpzQ8YCd1UajfdaQA1FtO/siQqzO3wLxlo
         4HOfbL4z+hu4XLwCSrzcCXp6PHqA4D408O5TY5IffwjAZrHfuf53Vyur6HNSJLzuuHbh
         1d+A==
X-Forwarded-Encrypted: i=1; AKwUvBxfhqvYBplqCqB1WN5EiFF4KXhY728kDy3ANvMXC87waqBxvt3fywMUiaLkah6RxaSoP24zsGbTVgqmpvzs@vger.kernel.org
X-Gm-Message-State: AFq9FYKrui3+nAeg2Cf7DiZBAr0J4tbFNqcTnPUj1Q4gpjEiHHHlHz6t
	NCQSAoXf3KqmUHfekJO1JiV0KaH9+7TB3IRPk8IMw+6mNkUwApuZS15HDmNmkUIwv9T/kaV/2Le
	J610fypZaBaga3FeGBCZP/3eWSZrd7b4=
X-Gm-Gg: AYBFou2k/9nKyIf7dKxgXkhNw0Zun7ABUTRJVZiLRVjVWbl8uYt1UwCulOCc17Qs2/u
	eRppHLwYIMJaVL5mtWIiAR335OncFWoBBpEB6qkHjzTx084czhc1ttnnn/tSB8X35tJOt9nm/Rz
	q05MIRav+HJMJDZ08VR2wqG4Gj/KCLYm3IOHDE3txP8sUKmPCzrnqinje5lCu7IOZXU//Oqh/PE
	F6RL3JKUMD96cWBysKtlWI3Z6++rNwbt7cYWyYxObbV50lTf43mu4OGrknVUXPh9FLMikz79mjU
	35e8NtaHRjNPZM8h9WN7NhqKyWjc0V9uzZtqvDmS1XhjQsG0kPzBNKg0kPnNUTTWbGlJsWYhqoL
	j3mz6rKmkUiU5SzT2dK7ONasLuZV3n3mMfTwQK2+LehG/RTxvXJwAO6DuRyuX6Y9TlwNZBmWIwj
	B8+jqiv8XWvQ4Pack=
X-Received: by 2002:a05:690e:1548:20b0:679:afc3:b990 with SMTP id
 956f58d0204a3-67a455751ddmr3346085d50.152.1793053679299; Mon, 26 Oct 2026
 15:27:59 -0700 (PDT)
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
 <20261012-dd-cmap-part2-clean-v12-23-3c8cc5725def@gmail.com> <sashiko-outbox-170722@kernel.org>
In-Reply-To: <sashiko-outbox-170722@kernel.org>
From: jim.cromie@gmail.com
Date: Mon, 26 Oct 2026 16:27:33 -0600
X-Gm-Features: AclHuK-iFp5xqB6d-LRnKDMtWnZXSOdE3cMaERLXso3BmPK_qGi1CmXSW6vaeP8
Message-ID: <CAJfuBxw9uTaqwRudCe7r8_G3-jh+VvRoEzoY-OcZXC=WpctzOA@mail.gmail.com>
Subject: Re: [PATCH v12 23/40] selftests/dyndbg: Enable FT_classmap_inheritance
To: sashiko-reviews@lists.linux.dev
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
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 8:37=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] selftests: regex flaw silently excludes submodule from test as=
sertions
> --
>
> commit d0e8e8cb940b9b06248942fb57c7a41c66ad8636
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> selftests/dyndbg: Enable FT_classmap_inheritance
>
> Exercise classmap state inheritance between supermod and submod, verifyin=
g
> that class settings and controlling parameter states propagate from paren=
t
> classmap definitions to dependent class users upon module load and during
> runtime reconfiguration.
>
> > diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b=
/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> > index c279c795867b6..d759243a4cbe7 100755
> > --- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> > +++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
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
g*\]')
>
> [Severity: Medium]
> Does this regex fail to match the sub-module as intended?
>
> Looking at FT_classmap_inheritance(), it calls slice_and_hash_ddctrl() wh=
ich
> uses grep to filter output. In POSIX Basic Regular Expressions (BRE), the=
 *
> quantifier matches zero or more occurrences of the preceding character (g=
).
>
> This means the regex matches [test_dynamic_debug] but demands that the
> bracket ] immediately follows the g's. It completely fails to match
> [test_dynamic_debug_submod], silently excluding the sub-module from the
> load-time test assertions.
>

fixed in v13

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
> > +    local hash_sysfs=3D$(slice_and_hash_ddctrl '\[test_dynamic_debug*\=
]')
>
> [Severity: Medium]
> Similar to the issue above, does this regex fail to capture the runtime
> state of the sub-module?
>
> This allows the equivalence check between hash_modprobe and hash_sysfs
> to pass without actually verifying the sub-module inheritance behavior.

yes, now fixed

>
> > +    if [ "$hash_modprobe" !=3D "$hash_sysfs" ]; then
> > +        echo -e "${RED}: Load-time vs runtime parameter equivalence ch=
eck failed!${NC}"
> > +        exit $ksft_fail
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-dd-cmap-=
part2-clean-v12-0-3c8cc5725def@gmail.com?part=3D23
