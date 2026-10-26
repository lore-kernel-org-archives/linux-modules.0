Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793054920;
	b=cOCi3dfLQEs7dJr3fSGqas2OBrV/KQREQ3qIroStWz2vJM17UgDNQI0DbnJBqHRpYeT9
	 km1iilH6TGz5UjVnrARygsPoU4fXww8s3amfBGlm4H42iUK0hC7zSIcmQI7KKKJ6fUOi6
	 iDt/TWHdKYrjeWKkQSuQ1sRz3I1vtXpMJeovGiftDBYazpyUSNAncpvYYmafM8upLe81V
	 RbOkPQ/mG/Pfh53GCCkkLfremDnc/PA+V1hrctYDdgdavYEMu46nRh5tTxwttnVVevz1l
	 yoEmZUgxlhIzDfgJJyzyB3emY90Z0myFhybVatZ8oGhFpsAZ4gdBBBXLiMrPt25jXmQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793054920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mshdBP7zWJ8tsttLUx6xhnibBdLHVDUK/dBlFucrT6E=;
	b=FCzM+XlE5PJC24n4Unc7d/aClFxrLe5/vCmXo/Tjl0043PGyvOd6l0WfF7QUo8wz6V/9
	 5vfQA9VYIHVgXVyANZcpJgNcXT6murzEENMblcMc1A4dYyLwla3YtbvTaiPq8il93Gniu
	 ImGMUy/l4BpkcYfrskKkwrBDiQIXmECA6Z/GT/lXlKYqR/1W/hfazH7wXfPLCoc1b223H
	 vXpr/NtJZtgXx2huado8L5k/Oo2WGxt2BqLnPAZqW+QGEe5nh8SRG+Rv3kZ/j9Y8tpUZW
	 vAcDahx3WrqH4jQkHUszkbhSLv7PodlcPEarx8l0aqygqAAZsWhtTE4fLaoq/u0068g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SnF1ntF4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424B1606A31E
	for <linux-modules@vger.kernel.org>; Mon, 26 Oct 2026 22:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 424B1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SnF1ntF4
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6798eb0d13fso3730505d50.0
        for <linux-modules@vger.kernel.org>; Mon, 26 Oct 2026 15:48:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793054919; cv=none;
        d=google.com; s=arc-20260327;
        b=VqHYSMBrWMPbgkkNAGaV1RpnUJyxfuh10rgdf4EjV4z39gHsBpynl2J50wyfxVQ/xS
         JTopH49x9v7T3trqtJDDYVoWIsRpiV4rP0ew5FFVYTVFUtLM+PPxsfnfiPRJY0mVfJRC
         tUnpqJRft98ccoolHBo/oABojiPd1TZ1AA+6PeKRaHKwTbxkqJQTlhAYDXqEalHWpBZ6
         wxKdTGMWZ1Jn5vUoi2iCm/br7yU5MZAL6WNkw69YfZpP1a1Uu9JZJsCPDI2fRdBtm8iV
         iJcLSTktkpyGvsXnOSQooKbgl+WG98aAlWBJ/k7hsVTMxawQQvyGlODp/vOW8S+uWdVa
         JdMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mshdBP7zWJ8tsttLUx6xhnibBdLHVDUK/dBlFucrT6E=;
        fh=wr5+RMRrCc1P2nSXvmHJMNgqBD1xePyDtdqcgpym9XI=;
        b=cVUrhf1lpURsRS4fU63LgCT83f6jLkzOLBJC2CAbv5pU0P1/TjKkzGraIYFRaoY5kY
         sPWa9HQ7rZO3LJfKPl4n4yroquzYutOHwQuTR8mfnUSWBEcGKRrgxu7HK393PxQ4Wq8w
         LFEJgy9kuDCM4xFCG3eR7UZ6ntjTnCsL7ipbSm1548N+flzwgdTjydkqFr+Ex+X+xL3q
         vXwWkWS6h65hCoXk7cvMhgA2v/GrpGaChImodIJJ7/vcp3netUEogeApmlZtYWO4l7L2
         LCydnF9z3iqQCQi7G3m+OHwZOvHfNj5wFeRaUd0m9968XplzmHb7gIclVFk0QC/86f+9
         V+6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793054919; x=1793659719; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mshdBP7zWJ8tsttLUx6xhnibBdLHVDUK/dBlFucrT6E=;
        b=SnF1ntF4XuLhwTNO4r8C2ofkbyMGGoR5PdXfNN9t9VWO3yFs/8r66gFcF1pdNQXepR
         kIJl0rsP1RI/QJNEhD6E+yBQMtCr8/NiDPP0/sPqOAEJQbcigh4QoPTtV1j4hmNIBMZE
         JtpnOGRAz9wHIHTLgqLBwyeXq15P6A00Oo8kMOjhQ3iK2kBHSKD0rNGzA7wm0vXSVzrc
         VADoUaE+fbMk8xm6WZNerxuTP4l2ZJEkEZgdKL2QZQ3lB/wB5ZxnsdYIu+6tsnhCmNzY
         iO0tVHNvUNJ3n2VwO2fW8ASjzII7w2kI4NwdAg4aTjTWsotY75oYDRofd6KgyLtNuQU7
         Y+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793054919; x=1793659719;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mshdBP7zWJ8tsttLUx6xhnibBdLHVDUK/dBlFucrT6E=;
        b=Cp68Zuwpcn8IiRe+f/SwiFK7OzLv3GrrrQsJyye1RKkGpehgfFTswTwxZbRG9A0OWE
         8PeCeJFxIEhNyatlfEyCEe1oyukySDIr23iIcXjgl7BMBt+8WU8ZNxvohoKGW0Azkizu
         uEKQIga4sA5m11E77cvtSr4QRJfBmCO9QpUOI9h0yEE9m2b94JOo+1WP2tx5GmibWzN1
         4VraNMkJM6kzjrC8CS9xT2LtcONtgkcmNTPgnKVN/WUbtL5jIpa8o5i9Gm0XLikSVHOs
         ijvFep0HYP7JzyWwESG9GP/yznpgmVrKPqcw/PrBIYIWXi7wq7eAz4UKgz2u7GeBp2YY
         RtVA==
X-Forwarded-Encrypted: i=1; AKwUvBzDfdxldYnL2MiusLBgyvOFNy58lUQgnQ7Iwvz60bGprOBRp3oBqPFyZ6XAT5AXMbAKc+CSKmBMyeLLbRCU@vger.kernel.org
X-Gm-Message-State: AFq9FYL6vgatr1r7NsorOsrgryWAxhFH3MCq6QavTzENIRG3AGB9Xfnx
	rxLaWjY0oU6CiFwvnVSLKDcc037VNQMlNsBYz21StC+MzXfzIPsALCeV2DZ2IyjpUZs7ToooOZH
	t8BwNhZrynidnXdzF/8LDjnEvF40knfk=
X-Gm-Gg: AYBFou3hIFj3V6fg0woTjx9H0FjEu5dwLaJiPsGUiHIefzH7mMbLflkYKhVIFjLcfBr
	qBgWR9N78JwQc4RLhWYlL8iLDlad52VFU87ji5++BCVTG8DrbUOwCPutn1Kwt2WiWhC58GOqlWK
	PvyM0WZjl4ZHJTjTvmc6cUE5gCXfsi0TdnZ6CuBH7axcHdDewPM7HW/l4LYDCRaK+eY5h9f86ZO
	HhUG/ued4JeC7UiaV8R88kiwoSokEG/lh3a8s1GUo6TzDXslJypwmPwPgUKAF22ygNMOLcfuGF0
	K8dvdOqy0+tO9xd7rh5M4fTvoZSEUpvB+RTgMEkvxCOrFCmss7FU1qiCywawvuDX1g60fmoDUu9
	ytjOD3XFF/em4b1kFbpHX+dNwBsh8+X28yrnkF4WEkG18an5Gdx4egUmECX4G2e3j7q1UYyHfp7
	WD30RnEEj+SXbaTTc=
X-Received: by 2002:a53:ad85:0:b0:672:ef39:5fc6 with SMTP id
 956f58d0204a3-67a454900ffmr2904378d50.147.1793054919173; Mon, 26 Oct 2026
 15:48:39 -0700 (PDT)
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
 <20261012-dd-cmap-part2-clean-v12-26-3c8cc5725def@gmail.com> <sashiko-outbox-170725@kernel.org>
In-Reply-To: <sashiko-outbox-170725@kernel.org>
From: jim.cromie@gmail.com
Date: Mon, 26 Oct 2026 16:48:13 -0600
X-Gm-Features: AclHuK_U9GeBl7u0-5vmIpwTNJsdz2Sn-v3e-HGd_0bRIhFESQNIVxLVo-t00Ow
Message-ID: <CAJfuBxxZ=znaXKhz6w3tT-qq-AKPQHWwzWr53w98k2wDAh3Ytw@mail.gmail.com>
Subject: Re: [PATCH v12 26/40] dyndbg-test: add do_bulk testpoint, rename
 do_prints to do_classes
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
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Low] test_dynamic_debug: classmap offset mismatch for submodule classe=
s
> - [Low] locking: param_set_do_repeats blocks param_lock for up to 60s
> --
>
> commit adf504f365302c7db4e37850cebef69f82ed353f
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> dyndbg-test: add do_bulk testpoint, rename do_prints to do_classes
>
> This patch renames do_prints to do_classes to better align with its purpo=
se
> and introduces do_bulk to generate high-volume workloads. It adds support=
 for
> executing these debug operations multiple times or over a timed duration =
using
> shared module parameter callbacks.
>
> > diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
> > index 01ce07001d4c7..19e27b5747ac2 100644
> > --- a/lib/test_dynamic_debug.c
> > +++ b/lib/test_dynamic_debug.c
>
> [ ... ]
>
> > @@ -28,25 +28,57 @@
> >  #endif
> >
> >  #include <linux/module.h>
> > +#include <linux/sched.h>
> > +#include <linux/sched/signal.h>
> > +#include <linux/jiffies.h>
> >
> > -/* re-gen output by reading or writing sysfs node: do_prints */
> > +#define TEST_MAX_REPEATS 10000
> > +#define TEST_MAX_SECONDS 60
> >
> > -static void do_prints(void); /* device under test */
> > -static int param_set_do_prints(const char *instr, const struct kernel_=
param *kp)
> > +/* re-trigger debug output by reading or writing sysfs nodes: do_class=
es or do_bulk */
> > +static void do_classes(int); /* device under test */
> > +static void do_bulk(int);    /* device under test */
> > +
> > +static int param_set_do_repeats(const char *instr, const struct kernel=
_param *kp)
> >  {
> > -     do_prints();
> > +     int rc, ct;
> > +     void (*repeat_fn)(int) =3D kp->arg;
> > +
> > +     rc =3D kstrtoint(instr, 0, &ct);
> > +     if (rc) {
> > +             pr_err("expecting numeric input, using 1 instead\n");
> > +             ct =3D 1;
> > +     }
> > +     if (ct > TEST_MAX_REPEATS) {
> > +             pr_warn("%s: clamping %d to %d\n", kp->name, ct, TEST_MAX=
_REPEATS);
> > +             ct =3D TEST_MAX_REPEATS;
> > +     } else if (ct < -TEST_MAX_SECONDS) {
> > +             pr_warn("%s: clamping %d seconds to -%d\n",
> > +                     kp->name, ct, TEST_MAX_SECONDS);
> > +             ct =3D -TEST_MAX_SECONDS;
> > +     }
> > +
> > +     repeat_fn(ct);
>
> [Severity: Low]
> Does this synchronous loop execution block param_lock system-wide?
>
> When test_dynamic_debug is built-in, writing to its module parameters via
> sysfs triggers param_attr_store() in kernel/params.c, which acquires the
> global param_lock mutex around the .set callback:
>
> kernel/params.c:param_attr_store() {
>     ...
>     kernel_param_lock(mk->mod);
>     if (param_check_unsafe(attribute->param))
>         err =3D attribute->param->ops->set(buf, attribute->param);
>     ...
> }
>
> Because param_set_do_repeats() invokes the workload synchronously (which
> can run for up to 60 seconds as shown in do_classes() below), this starve=
s
> param_lock, preventing other processes from reading or writing any
> built-in module parameters for the duration.


    In standard usage, test_dynamic_debug is built as a module
(CONFIG_TEST_DYNAMIC_DEBUG=3Dm).
    Under kernel/params.c:KPARAM_MUTEX(mod), modular parameters
acquire the module's
    private &(mod)->param_lock rather than the global param_lock. The
lock-hold is
    strictly local to test_dynamic_debug's own sysfs nodes and has
zero impact on
    core kernel or other module parameters.

    Even in the hypothetical built-in case
(CONFIG_TEST_DYNAMIC_DEBUG=3Dy in a test
    kernel, which I would consider mis-configured),
    test_dynamic_debug is exclusively a test harness whose workloads are
    triggered on demand by explicit sysfs writes. The loops call
cond_resched() and
    check signal_pending(current) on every iteration, keeping the execution
    cooperative and immediately abortable via SIGINT.




>
> > +
> >       return 0;
> >  }
>
> [ ... ]
>
> > @@ -103,7 +135,10 @@ enum cat_disjoint_bits {
> >       D2_DRMRES };
> >
> >  /* numeric verbosity, V2 > V1 related.  V1 is > D2_DRMRES */
> > -enum cat_level_num { V1 =3D 16, V2, V3, V4, V5, V6, V7 };
> > +enum cat_level_num { V1 =3D 16, V2, V3, V4, V5, V6, V7, V8 };
> > +
> > +/* test _USE_ w offset */
> > +enum cat_level_offset { Vu1 =3D V1 + 8, Vu2, Vu3, Vu4, Vu5, Vu6, Vu7, =
Vu8 };
> >
> >  /* recapitulate DRM's multi-classmap setup */
> >  #if !defined(TEST_DYNAMIC_DEBUG_SUBMOD)
>
> [ ... ]
>
> > @@ -160,6 +183,19 @@ DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_emptyclass, 0, =
0 /* ,empty */);
> >  DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_maptype, 3, 10, "no such type");
> >  DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_base_len, 0, 60,
> >                             "base", "plus", "classes", "length", "too-b=
ig");
> > +#endif
> > +
> > +#else /* TEST_DYNAMIC_DEBUG_SUBMOD */
> > +
> > +/*
> > + * in submod/drm-drivers, use the classmaps defined in top/parent
> > + * module above.
> > + */
> > +
> > +DYNAMIC_DEBUG_CLASSMAP_USE(map_disjoint_bits);
> > +DYNAMIC_DEBUG_CLASSMAP_USE_(map_level_num, 7);
>
> [Severity: Low]
> Is this registration macro passing an outdated offset?
>

yes - fixed in v13 (forthcoming)

> The patch adds V8 to map_level_num, increasing its length to 8. While
> cat_level_offset correctly shifts the submodule's class definitions by 8
> (Vu1 =3D V1 + 8) above, this registration macro still tells dyndbg the
> classes start at offset 7.
>
> This mismatch causes submodule debug callsites to map to the wrong class
> IDs, leaving the last class (Vu8) completely out of bounds and
> uncontrollable.
>
> > +
> > +#if defined(DD_MACRO_ARGCHECK)
> >  DYNAMIC_DEBUG_CLASSMAP_USE_(fail_offset_big, 100);
> >  #endif /* DD_MACRO_ARGCHECK */
>
> [ ... ]
>
> > @@ -210,20 +247,85 @@ static void do_levels(void)
>
> [ ... ]
>
> > -static void do_prints(void)
> > +static void do_classes(int ct)
> > +{
> > +     if (ct < 0) {
> > +             unsigned long timeout =3D jiffies + (-ct) * HZ;
> > +
> > +             pr_debug("%s for %d seconds:\n", __func__, -ct);
> > +             while (time_before(jiffies, timeout)) {
> > +                     if (signal_pending(current))
> > +                             break;
> > +                     do_cats();
> > +                     do_levels();
> > +                     cond_resched();
> > +             }
> > +             return;
> > +     }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-dd-cmap-=
part2-clean-v12-0-3c8cc5725def@gmail.com?part=3D26
