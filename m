Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.224.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793053489;
	b=xspnkwfgYGd2RHuXSfKVTMNpxkn3njGYZ9r3CaYzVib2mzMMhtEM/BPnKPk4S11EbUdN
	 5Gx75mbgqQZyTtisTNKG3F5qa6qRID1ka7z6O0EzXJJntBownanr4Ybq3TdpbT6GRAR0e
	 LO6DiRswXL2qEHeJubJq9hMWjGsFUJ+3b9jU3PbxenHFwYCfPCVzWnXIEmG+SryQD4R4t
	 +alysuDCOrICEcfpgA0qSccf7KAtEbZcABvEAqsmXKSTMAdP1dsGmb/5ChDTX/StpQcPf
	 nhom5C9Kk8UhsI5zS6dOn9ioL3RUS9bO3ge0LUGvpXCy2iZbeprBISY4GhKJuW4qr5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793053489;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=iVjafvKaFWiL8zTdM57JrvEcpVYGEcYrmsTnFX/+S2w=;
	b=0M8Ph1IaU7mmGELGqrS6gtTn3E+R9EJwUzzpUb7q6SDyWLtl015mgppqlv9pbww1YZax
	 TVr2jqYX8RMkGd6CvfsoMqWWSQ2ii2t3cR/zxdA/3lKkLFlMXH9w5ZjCjnbU9yHRvolyk
	 PDlkZRb1TNUincT7EzORgbxiWHF1ZgSTcYezNv7K9FNE4a2v43H83Th1fDU2d6xDAZzQU
	 Kq66AyDnofAm7DL2hJKU5w+avmvIrR6KP9MiESl5KeBzy3bnG7PP3ngp+27DRcA4ZfqT6
	 805PxU2FmIov1fF8UDoo5ztsZ4xsBK5mnHeBILUtoDjm9358j1Z7CwKAR1cTGL2gBkg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c2s7DBsk;
	arc=fail smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06931606A320
	for <linux-modules@vger.kernel.org>; Mon, 26 Oct 2026 22:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06931606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c2s7DBsk
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-67992884b02so2305510d50.3
        for <linux-modules@vger.kernel.org>; Mon, 26 Oct 2026 15:24:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793053488; cv=none;
        d=google.com; s=arc-20260327;
        b=NOzTQyiXjs3JhMyNE8RalYXRvsdJbfdQ7MAK2Kd1X+YNpG17nuIkxZupowNRljR/lS
         sMKUkgrFh/1MDgXqZ4ny+GAhRSeUjGMTvNVjMAnECgj6TtYQ/4VCkDolzgwhsL2UYUnB
         zTAGkQM48x4q+Prx69I9MS0utM3whu97bdiXGpD5AgNrmp35+/dibT6goJI9iOoV7p04
         ynq7OVIVo+Z6HxxEaZm97iYudF3Lvl7i3TCuNNnOyAdJs/otcJA+PkTfzWRBNdZuNXlo
         sIiM0AxwBkik09nj9ZVNcUIvGuAONzGfNBe6DThlYb95FygpTq8VoGPibRNpt4fbZDYD
         eHQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iVjafvKaFWiL8zTdM57JrvEcpVYGEcYrmsTnFX/+S2w=;
        fh=qUlgcxOn46TsTRux1MRo5XB/OSt3+520pwUwJxi8AUY=;
        b=aj8kapab8t6OXNNwq0BuZf6TrPNLuWDDBlw2lGZubkmpS5DXdo3Sqqcc1xPabcI8Ir
         JhCP9caR9c4gcuQXQ4yvm4HI0ZdvqyRcpldmHlg+7loyq/r/ML7EXJ0U02+NTVIxKDBd
         eIdeyCAlfkNDta7ErosgNc4fhMEvnl/wrjn3EwwFN9SuPXucW4jg8zaRGuMaLXonaWwA
         FLn3KoHNvfpUXFc3pwis0DIzJI6//cusR5nTsAKzfeMCwQr89uBebeKMedyPPxuvIPwk
         LUGalyh23K0GkeabSeHrEJokFlilK0+1HMNHBSvzsxHqpj5WWaAdz41CbM+xawoicD6N
         D3xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793053488; x=1793658288; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iVjafvKaFWiL8zTdM57JrvEcpVYGEcYrmsTnFX/+S2w=;
        b=c2s7DBskOhvfJJ61QD/0Zb2RwvTJAtol98X82VPH5bJCdK1jeJCuXYj0R8Pfkd0/6f
         u/+qLRW+SIs6mqZu/qievNAx+5F/Ao0g6vtkvby05zNHa7lRBUYKowCXXR5gjpIzXmri
         Nx4S2Xr1N9sOvPFYuLcs6PGg9Z2COyVbdKAKvgz4Jo6DzJqYdh2WIQlQ3AZAy+Pq/ffO
         zXmFhzkHILnmPBpjImE1OblR0yhc8mAMLf1k3sClKY9JOtz9VGEpg4w9qUDHX2fm71Oc
         Sr5g4JlabkOj1rxnvmiNGF/EXksUCBWTEzI0Z+k/TpNJ0w0t2HLdpm0+i5hVUsolr93i
         5yAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793053488; x=1793658288;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iVjafvKaFWiL8zTdM57JrvEcpVYGEcYrmsTnFX/+S2w=;
        b=qF+0luzhUPWnJTKOHtZUE3e6OH56zP2xI7TYi0zhkDtMPvn1s8JGuV44L3AxXqPfEu
         dPJgPCiIXwd3uqqiTDNeW/CeIK5kHopjvcr1bJvfbnygw1ZlXFl0r+leahZA1m6Ifyeg
         tU9GcZigEs2MfBNP8xl5XvVe7/rbI3wD75aR2HgkoAVfRPUXdBGYiudP5mOKl5r8EoA9
         Us1DnbRe0/n2D+6tGWYzkLXhRhXMae+XJZ2RLc4kvw5d6M9E60QOirUEcQgBAfVJHSk/
         sSkPid01DXz0ZNHcwdCsvqSGqJZFoardGMNxCV/kNdKY8T3SjQsR1nILhMdgXK7n6CV/
         cVig==
X-Forwarded-Encrypted: i=1; AKwUvBzimgzXo0oRMQpdoYkZASAjAsNtB6wf2iXzgUDlnxKPRS4INXA44OV1GYcQ9lEO9ROKH/efH/XcggpF22qW@vger.kernel.org
X-Gm-Message-State: AFq9FYI8e6SRu0ODZv1rgdPcXizdUfuKKvIaZFVfFikklZRAEbwNKZHs
	ki/HwN9jjCsNf6gHInDCt49KzkEoTyvnY2a0LQaJ/eQr/A9PkD8PDoBooKDyAZoxmESUwy+se1W
	PLZorm6i9ZzIOaL/YvG8hTFcCy1pfewA=
X-Gm-Gg: AYBFou3MXI6gWVJhPXeD9WNf7uH42rtgNYzFbsBndC/YH3F019H3yOB6mm4MdeP3L9h
	LS1r7PLNKeBrM/BUD9g029855vi8kOAM8wIEND5DbG/WFGRFKmJZZ+tjnrWg5ZPrOGMR36NOGC/
	yz31Nz8I5H8u2/Gee+YAMtNC4+JdIL7VbFrzt6q98h479qNUO1AdJWwI4a3+IwkXETfSOPByEjF
	DjS/pDeSAfD/pQ4wWwm8sCUF+BKazD0V7NmmRmAlhZUQSispZ4uRovvDu3FPNf5mIg+2eMCkPT2
	f5jK4+Gl15WvdUAI6MgmVvamu0IRII/t3SKkw6nYh8GbqW1XHDxqvBNr3+bLa3v37VMqeIbSSd4
	WxM2dcKwgFCiNdJIKQ6Q4gVv1NIxWeIlWqkQYLoz3sosuzGZRU2f55Ok9I5tqYFUtMwVHaYzkMy
	FiqPdgcXTNuqr3UFuInG9ivZzG2FDJMBav5H1F
X-Received: by 2002:a05:690e:dc5:b0:677:cbe8:4fce with SMTP id
 956f58d0204a3-67a45500fcemr5471600d50.79.1793053487746; Mon, 26 Oct 2026
 15:24:47 -0700 (PDT)
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
 <20261012-dd-cmap-part2-clean-v12-1-3c8cc5725def@gmail.com> <sashiko-outbox-170708@kernel.org>
In-Reply-To: <sashiko-outbox-170708@kernel.org>
From: jim.cromie@gmail.com
Date: Mon, 26 Oct 2026 16:24:20 -0600
X-Gm-Features: AclHuK8NnuLVLON4lfx7cNxK26K-bWlrdBylLKsqpFu-v1Gz5G-bY8ivxELQPKw
Message-ID: <CAJfuBxzw4jWufuQhgstnYFtkC=+VyV9nNLi9R3xTuJEVsWbuNQ@mail.gmail.com>
Subject: Re: [PATCH v12 01/40] selftests/dyndbg: Add kselftest script to
 verify dynamic-debug
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

On Tue, Oct 13, 2026 at 8:36=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] selftests: test flakiness from unfiltered dmesg temporal slici=
ng
> - [Medium] selftests: test failure coupled to unrelated kernel/params.c p=
r_debug churn
> --
>
> commit 56bb89808ed29ee403a2b674106329de27cb9b06
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> selftests/dyndbg: Add kselftest script to verify dynamic-debug
>
> This commit introduces a dynamic-debug selftest script and a reusable hel=
per
> library for baseline-change-verify testing. It uses spatial control-file
> slicing and temporal syslog slicing to verify valid syntax, error handlin=
g,
> and basic queries against the built-in kernel/params.c file.
>
> > diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b=
/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> > new file mode 100755
> > index 0000000000000..c1475c7555429
> > --- /dev/null
> > +++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
>
> [ ... ]
>
> > +function FT_basic_queries {
> > +    v_echo "${GREEN}# BASIC_TESTS ${NC}"
> > +    if [ $LACK_DD_BUILTIN -eq 1 ]; then
> > +     echo "SKIP - test requires dynamic_debug built into kernel"
> > +     return
> > +    fi
> > +    local f=3D'kernel/params.c'
> > +    ddcmd =3D_ # zero everything
> > +
> > +    ddcmd "file $f +mf" "$f"
>
> [Severity: Medium]
> By strictly validating the exact state of kernel/params.c and hashing the
> normalized text, won't this test break if an unrelated upstream commit
> legitimately adds or removes a pr_debug() in kernel/params.c? Does this
> inadvertently couple the selftest to unrelated core kernel changes?
>

Yes, there is a certain amount of dependency / brittleness
IF kernel/params.c is changed in certain ways.

That said
1. kernel/params.c is one of the most stable / unchanging parts of the kern=
el
2. tests that change flags and verify the changes are needed for
adequate coverage
3. tests against builtin pr_debugs work even when test-modules are not buil=
t
4. line numbers are excluded from the verification, eliminating that
source of breakage




> > +    ddcmd "file $f +l"  "$f"
> > +    ddcmd "file $f -m"  "$f"
> > +    ddcmd "file $f =3D_"  "$f"
>
> [ ... ]
>
> > diff --git a/tools/testing/selftests/dynamic_debug/syslog_hash_validati=
on.sh b/tools/testing/selftests/dynamic_debug/syslog_hash_validation.sh
> > new file mode 100644
> > index 0000000000000..8c6e91f5d9c27
> > --- /dev/null
> > +++ b/tools/testing/selftests/dynamic_debug/syslog_hash_validation.sh
>
> [ ... ]
>
> > +function verify_dmesg_slice {
> > +    # Slices dmesg, computes its hash, and verifies it against the dat=
abase.
> > +    # $1 - unique test key (e.g. normal_513)
> > +    # $2 - optional start marker (defaults to ${APP}_START_${label})
> > +    # $3 - optional end marker (defaults to ${APP}_END_${label})
> > +
> > +    local label=3D"$1"
> > +    local app=3D"${APP:-DYNDBG}"
> > +    local start_marker=3D"${2:-${app}_START_${label}_$$}"
> > +    local end_marker=3D"${3:-${app}_END_${label}_$$}"
> > +
> > +    # 1. Capture the log slice (exactly once!)
> > +    local log_slice=3D$(dmesg | sed -n "/$start_marker/,/$end_marker/p=
" | \
> > +     grep -E -v "$start_marker|$end_marker" | \
> > +        sed -E -e 's/^(\[[^]]*\][[:space:]]*)+//' )
>
> [Severity: Medium]
> Since verify_dmesg_slice captures all kernel logs between test markers an=
d
> hashes the entire block without filtering for test-specific messages, cou=
ld
> concurrent unrelated kernel subsystems (like networking or RCU) emit prin=
tk
> logs that alter the MD5 hash and cause false positive test failures?
>

All my testing has been done on VMs, they are well isolated from
unrelated subsystems.
ISTM most CI-CD testing is done that way.
If needed, we could easily add grep filtering later to select only
relevant messages,
but it adds its own maintenance burden; it doesn't seem like a blocker to m=
e.

> > +
> > +    # 2. Compute its fingerprint
> > +    local fingerprint=3D$(echo "$log_slice" | tr -d '\r' | md5sum | cu=
t -d' ' -f1)
> > +
> > +    # 3. Verify
> > +    verify_fingerprint "$label" "$fingerprint" "Dmesg Log" "$log_slice=
"
> > +}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-dd-cmap-=
part2-clean-v12-0-3c8cc5725def@gmail.com?part=3D1
