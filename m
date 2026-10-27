Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793060806;
	b=DiBbC+1zACIXXsbWXUAtudYttMGfUDHYR3uL1l++mhmNuUrpRKHYFKJ0Jpo2al8+/mBz
	 mHXTxqPwNGvqLTGp/37G4RB6AYrGlD7/WoJBCQTymAfu4EdYHNGDQUtNh9ngYM/0YcaJd
	 qPyowTSq/ASutQ0lGLTgVxVV8twcqRNSJD3GNpTCJyQZFZjfImNXYUoi4ulPyezKVPWQC
	 1e9L6BHftwCvJ9A3GwrQEukfcAQ5AEJqhUfsgbjhlQvflstAW9bicaxCN+qohA2CjJ3hK
	 4QfahMzgwcQXIAD2X61WvorU4h5lhtwexh8aIHK8fNIZ2MyCLV3dtIr7QwUmXburQzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060806;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=eybqDydWM/qmE6WTUncvgQt2QyS6Zq7ps/uXBzvWlWc=;
	b=yAOfcVZpi7VaeeMZoNqP+Ke+Y+u3MLaDau69UDvO++TIqIwiXeAQCLpQUY9AREB0aozY
	 nDa+5bEZ2kIv1ZrwoxBi+2vkvOfJoL8V+Imcn5wOpHERwaRFhMY8CeRjThPya4jvlN3x3
	 00uwNIUwlUuFoLS3FYlIk9gYW7eLorsDd+V3kT8s9bUnfYYydsYmTtR69lPUg6cyA4DbC
	 HySFI8jxIKI6+1dbuqNxUaoxInqMX0p2/pd+1Z8UcbQl3fNC+0RkDTUGwuivUbdNTxDnY
	 LhtDEZO8IfdtoNacREF6RiyBf5AaImKt8TUVdGZ5FSs8jLwr4FFFjOcz7fhjfNle77Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QM9gFSMu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C86B606A31A
	for <linux-modules@vger.kernel.org>; Tue, 27 Oct 2026 00:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C86B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QM9gFSMu
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-676804a3a22so3568822d50.1
        for <linux-modules@vger.kernel.org>; Mon, 26 Oct 2026 17:26:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793060804; cv=none;
        d=google.com; s=arc-20260327;
        b=gpDzDfUjNKlwGSLKk9AtOssF+j+D+X0QdfGAM9ut1wBSU+pX0KWO5oSM5e+EwjKNKz
         BH1zm+A9y8ZtEtnXLxxQhGWWkDlup+lIPEpJ4hn+Rx0P8KnPR2a8NecUzgmAM73ur1bh
         KyxZ/Bz0FLx9CWZYq8066LCCLEfJIDfnLnDOqE4tg3u1AGwxWNXgyJGCBx7eFYNRuUmm
         FB50aYW4Uh2Uo33QTrxfWoTxTXieqB91+tpIiYtT5rvi6btuAiZ2hN2lgTQIGselRmHb
         IJ2hHUU17GGEG8OVFXUZyUi82Y0U2+49M2nwtOyrAGKlMPkqb3iDvcnn0ejAlcyliTTP
         L6QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eybqDydWM/qmE6WTUncvgQt2QyS6Zq7ps/uXBzvWlWc=;
        fh=HXxW+M6ys02Zp78Am/pec6BZxf3hEgiTTGI3mQrayCA=;
        b=ATInsIRrMkvtywgIhAIE2rDzQUYZ1zaEtVrtNFgagPkMFU2RIhq7o1ZqVPDp/0GsAY
         iht3KiQkvUXyhViINk9u1yoLXoOEBuJh7l2MKI4ZEKW7lutQwED1OM3mApdKp5zZ2cph
         mVcs5K4qiHmekRjUEwEjGTrPdtDzRuFE4DfqJFyBCafo4HeaAyuUKyEQgCMC2tuMACk0
         i796IIx7rKzLovybZyUWFs4i2sU2RtUJ6CsCE+THfblglauAoc3XpoNKFbi+E8yZVxRx
         QAUJ8+THsit0NJPgHGaNMsPw/SYcUTNEXzjC1kvI9XlzgWBs4pG8Nlag3nS1rPXQJfSL
         hsxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793060804; x=1793665604; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eybqDydWM/qmE6WTUncvgQt2QyS6Zq7ps/uXBzvWlWc=;
        b=QM9gFSMuY14PSarLpBthEE5PSTtYJ5iQwfgHQXQxXdgyxSiGBeDMvvVy2F16VP31j3
         ZaD0gTSPQ7tBhZ8ywZEs4Mm32UcUHxBy8wqngXv0QxgVX4bM5zngRoe9iRD86veEOOAa
         AIQ4D2vzgjQ7WStKg+WIRR7tSxPvc4jva8g1Yn2WwYrlnrKElf+xegqOTHz7oitichVP
         dnws6dF3IsUeHfMvlUNqB7rY7WfWfR9B958oJT0/dYdusZ4FBwZLq19JmVbiO9PglY1J
         mtt7Cszp0e/J70gkbUSLxEG2XPWXTagQQgdGm5KtjXRmuQR1c/V8ld1q7G07yquEPoCy
         GREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793060804; x=1793665604;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eybqDydWM/qmE6WTUncvgQt2QyS6Zq7ps/uXBzvWlWc=;
        b=dho6BPpepP1MJk3bvgpduYvHBrXeHHjATMXSfZdqz6ijgqg70FIPq0WtU0MTQ/rlQm
         471h+u8/isxjMmiRq7wnDeYeYnFEhsiTOkLY2EVGAFoJnyBODFCX1BXCsTbdFqoHGVRV
         1ppZaVhUGMV8seTzREXaCuaJh1tdYnkxg42kyFFc9Xh92pD+mA1NcnIkCoq0Cb5Q0P6t
         Are1tjS5P0CmkvTk7MHsimqDEEeTThRLLKpiaPhoPPKFH9o6MInlQwLrYAHVgJdArNoy
         hxVssyCkZ6LVh4nCt0qvxME5ORiV9NIoboLW1olbDjKmlP2TFW9hZuxLKZaINErhM2qo
         x3Ew==
X-Forwarded-Encrypted: i=1; AKwUvBwu/tNdwQuJvlnjhQuTpE/ddIG6MZPd97J1JIOZ2tOuE3dZ1sPOZNAFUO3h/0SVwZXQGVfx2Gqdgc5xyx68@vger.kernel.org
X-Gm-Message-State: AFq9FYJIm36bqq68G6fVj0LIiYcjt1+rfGKns8AX0BY37Bl00TkuwW/6
	uSiZopl+RhboarB/gWAevsrV/eDIzgK/NF1Nueq0YasRBWag5y7tuj1E0WpIyYt3nSM66PbqWF8
	KgUrXz5naNXJIv8GaNwcs/lyVsQjDwL4=
X-Gm-Gg: AYBFou2INDIm645tNmq8GGlhL7hddT7kNxn98GjjE9KYxanFf53X0EAld+nXY5yvhZ6
	eqbshtp4jSNyKF7xZYH1l2Chu8trlHQwdJsepTSWIcgKxGhbNX0WUN9oVuKazWY1C7zubkLsPf3
	+QS3sNRjvbuZxuCfZ9QH53WSBTA9SUfolVj+oaTSIJ2D+ocm+rlXspluy8E9R0LHoIIJTGKo+O0
	LSqYCyC3pprhTFsDm9TfuxmaMUxj/s6BZlMZpbD0dvWkeYeiBK3eXlqNX7gDAszXjFtzflG73oy
	oNY9hgoXhDMO9D/t9oZLBBThErMCtgTansOiN4V91iaI4MNgc0gzp0vlAFE7w3Lkt7ILchTYYzA
	1Vnl+hFiUUelZaR9L7rL9IUHKK5n+YKR7unDgULIVIVxObOTS4XkpHkSRsHncvMyRNXKtrUM7h/
	namjebjkN6MtKy1DU=
X-Received: by 2002:a05:690e:450e:10b0:677:ca67:98f4 with SMTP id
 956f58d0204a3-67a453de253mr3907194d50.45.1793060804234; Mon, 26 Oct 2026
 17:26:44 -0700 (PDT)
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
 <20261012-dd-cmap-part2-clean-v12-10-3c8cc5725def@gmail.com> <sashiko-outbox-170703@kernel.org>
In-Reply-To: <sashiko-outbox-170703@kernel.org>
From: jim.cromie@gmail.com
Date: Mon, 26 Oct 2026 18:26:18 -0600
X-Gm-Features: AclHuK_jv-lTnu6VYS2062o39f_E507yFRpnLLpthRIG1YaVwpNMuyVZmZdMW28
Message-ID: <CAJfuBxwNEG2ukJbPyVqdu0jKN4_CGh_ZR1pYj1z6AJTErfLakg@mail.gmail.com>
Subject: Re: [PATCH v12 10/40] dyndbg-API: remove DD_CLASS_TYPE_(DISJOINT|LEVEL)_NAMES
 and code
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
	linux-kbuild@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 8:36=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] dyndbg: documentation references future struct _ddebug_class_map
> --
>
> commit 4edbf52dcd2e7bd06805f06e89c8d2ce8672c81b
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> dyndbg-API: remove DD_CLASS_TYPE_(DISJOINT|LEVEL)_NAMES and code
>
> This commit removes the unused DD_CLASS_TYPE_DISJOINT_NAMES and
> DD_CLASS_TYPE_LEVEL_NAMES classmap types and their corresponding code.
> It also renames enum class_map_type to enum ddebug_class_map_type.
>
> > diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debu=
g.h
> > index a10adac8e8f00..9607121c3072e 100644
> > --- a/include/linux/dynamic_debug.h
> > +++ b/include/linux/dynamic_debug.h
>
> [ ... ]
>
> > @@ -119,8 +109,8 @@ struct ddebug_class_param {
> >
> >  /**
> >   * DECLARE_DYNDBG_CLASSMAP - declare classnames known by a module
> > - * @_var:   a struct ddebug_class_map, passed to module_param_cb
> > - * @_type:  enum class_map_type, chooses bits/verbose, numeric/symboli=
c
> > + * @_var:   a struct _ddebug_class_map, passed to module_param_cb
>
> [Severity: Low]
> This isn't a bug, but does this documentation reference a struct that doe=
sn't
> exist yet?
>
> The comment here refers to struct _ddebug_class_map (with an underscore),
> but the macro DECLARE_DYNDBG_CLASSMAP currently instantiates struct
> ddebug_class_map. Is it intentional to document the future name before th=
e
> actual struct rename occurs in a later patch?

yes, intentional.
using future-name avoids having to fix it later.


>
> > + * @_maptype: enum ddebug_class_map_type, chooses bits/verbose
> >   * @_base:  offset of 1st class-name. splits .class_id space
> >   * @classes: class-names used to control class'd prdbgs
> >   */
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-dd-cmap-=
part2-clean-v12-0-3c8cc5725def@gmail.com?part=3D10
