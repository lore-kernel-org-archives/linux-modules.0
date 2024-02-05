Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA80F1BDC8
	for <linux-modules@vger.kernel.org>; Mon,  5 Feb 2024 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136676; cv=none; b=iLH62mf/5tqGdffe3q/jC8tTuAVPFSRMHRhQRO0dzqXKWrgo4i3ltxX66OH3J1+xdkHc1bKWLmEU7Ayp+744By45OdMEUhBFB3WU6zbeqSEczUGSQujPVgag4ITmNrr/5OXQ53GXcGw7ZM2u2pCukiqjiYhT4KI9w7YkUhJ5PHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136676; c=relaxed/simple;
	bh=ZEHuM+lzvtDon5xA2gSbodwaHwlYajUxlD5hxTfIo4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8Up+GYVYMGxifnplf2bL5qcybnmnsAK1/ITTFAHdMwD2PZIMajj33caybkBK2u4e8C8EPVW8fu7SEM/uKVmd0nIseuNlQTazcUSgLyUZSCTRyK4RU+HP1cffJOGrZbEroHffZmiQVE9LezIQsfbdzAIE2VsadEDuy1Qmn7lA+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amiWN2xu; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amiWN2xu"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc6c3902a98so3090191276.1
        for <linux-modules@vger.kernel.org>; Mon, 05 Feb 2024 04:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707136674; x=1707741474; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5oaObEvAk/KPkSFMGbI3rJtXj3wVHkBjFSHYMQlpVeA=;
        b=amiWN2xu6r2RyrPpYqz1QeN7B0tqx5Q/aTiC6uhlAUVxOX0kFAg8V/TUqr9CyoWvfM
         /KXUwfbddNK3W/4j0Sr+UOss/Qk1fpLmsiTecXLvgwUpNAHYRKdWQdirJ4pY8NQhYAK+
         QPOC45wowhPfFkR+GKOBHDjXhTsqqDP8VzGgjQRlPr7UdFTf8KLHX3hgfs8A7rTBQqpC
         KERHh6OkOpYkE2ybKurZeu8xPmDromKsxj6xxwgLfNK4FDfpmOQoX1mpjFvf9A8VqG7W
         3WK6ExFT3jdgJGvqYeLK2j7QIa+BTXFJS2aqLWSmASaYnvS0aSoLsojGos0598j3FFtk
         7k/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707136674; x=1707741474;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5oaObEvAk/KPkSFMGbI3rJtXj3wVHkBjFSHYMQlpVeA=;
        b=ZAQUvzoLJMEbcMdfC3iQ3bbwIoZ6Q4AFV3cUPO716Y0LAtDkbZi5jQNGdFjXl801gx
         BUn4rh6HC62F9khkeChKay/1Qfj1ZVOzCLQBK2lbimgpawX2wXZvA/Y2JYk4H5Dh1dhX
         ZqtZ0hh2kZSCgBLcgaRggDfy5HCHrfT1ede5Rn6Sntt+cAUKgZltdL362IOp/kNURZ2K
         UQozi9PzTriaUgzS8zS9Zc5KrR65TJutVWdoQt1OXY1+jo8FmrYHcGdnIWd00y6EmhsA
         y8/91wF2ry3K5g7izqXvmnFnU20BPu3i8eKcWAgASsgz8KAfhm2LRB7uE6zghk/55KA1
         7FTA==
X-Gm-Message-State: AOJu0YwHSE63GBr4AzQSGp6qorPeeae2MGCOkOGX7v77vOWlu0466ZjX
	ksts1gqv162h+i6e8kMYkKFs4AVtE6IPsn3Ia/pcAEmWF3ED0J6CUgxBZZbdr8zzOgbUoAlVIca
	e4h7a1/rPU5c8DhpPPl4ATuDqQuFBERjw5Bk=
X-Google-Smtp-Source: AGHT+IHAs3/P9+53wMcvQ9UOJdSIGgQZzadb1OrhB56ecZiimU5MwUr5XSeT80gy9jM3Ae3iBSEz44ZJA0t5DZ5OwFY=
X-Received: by 2002:a25:7157:0:b0:dc6:1869:991a with SMTP id
 m84-20020a257157000000b00dc61869991amr11337976ybc.5.1707136673717; Mon, 05
 Feb 2024 04:37:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126-master-v1-0-6257d039a30a@gmail.com> <20240126-master-v1-2-6257d039a30a@gmail.com>
 <zeoywwedo4muolir5ietylb6xm2wu66wai77h6rvy2hkmu3u2f@f26b5cb3s6lf>
In-Reply-To: <zeoywwedo4muolir5ietylb6xm2wu66wai77h6rvy2hkmu3u2f@f26b5cb3s6lf>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Mon, 5 Feb 2024 12:37:42 +0000
Message-ID: <CACvgo51R=2WTcLma1wPSaDMu4QFtgezhGUKXf9k66Zg=6ZZ3=A@mail.gmail.com>
Subject: Re: [PATCH 2/2] make: install/uninstall tools symlinks to kmod
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-modules@vger.kernel.org, Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"

Hey Lucas,

On Fri, 2 Feb 2024 at 18:53, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>
> On Fri, Jan 26, 2024 at 02:43:51PM +0000, Emil Velikov via B4 Relay wrote:
> >From: Emil Velikov <emil.velikov@collabora.com>
> >
> >Currently we create symlinks like modprobe (pointing to kmod), during
> >the normal `make` build. Although those were never installed.
> >
> >Add a few lines in the install-exec-hook, to ensure they're present at
> >`make install` time. Thus one can actually use those without additional
> >changes. As an added bonus, distributions can drop the similar hunk from
> >their packaging.
> >
> >Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
> >---
> >Out of curiosity: are there any plans about releasing v32? I'm
> >interested in the recent /usr/lib/modules (module_directory) patches.
> >
> >Thanks o/
> >---
> > Makefile.am | 10 ++++++++++
> > 1 file changed, 10 insertions(+)
> >
> >diff --git a/Makefile.am b/Makefile.am
> >index 4062d81..a22d1b1 100644
> >--- a/Makefile.am
> >+++ b/Makefile.am
> >@@ -111,9 +111,19 @@ install-exec-hook:
> >               ln -sf $$so_img_rel_target_prefix$(rootlibdir)/$$so_img_name $(DESTDIR)$(libdir)/libkmod.so && \
> >               mv $(DESTDIR)$(libdir)/libkmod.so.* $(DESTDIR)$(rootlibdir); \
> >       fi
> >+if BUILD_TOOLS
> >+      for tool in insmod lsmod rmmod depmod modprobe modinfo; do \
> >+              $(LN_S) $(bindir)/kmod $(DESTDIR)$(bindir)/$$tool; \
>
> I was about to apply this, but then noticed a problem: I think we should
> use a relative symlink here.
>
> $ DESTDIR=/tmp/inst make install
> $ ls -l /tmp/inst/usr/bin
> total 700
> lrwxrwxrwx 1 ldmartin ldmartin     13 Feb  2 12:44 depmod -> /usr/bin/kmod
> lrwxrwxrwx 1 ldmartin ldmartin     13 Feb  2 12:44 insmod -> /usr/bin/kmod
> -rwxr-xr-x 1 ldmartin ldmartin 715432 Feb  2 12:44 kmod
> lrwxrwxrwx 1 ldmartin ldmartin     13 Feb  2 12:44 lsmod -> /usr/bin/kmod
> lrwxrwxrwx 1 ldmartin ldmartin     13 Feb  2 12:44 modinfo -> /usr/bin/kmod
> lrwxrwxrwx 1 ldmartin ldmartin     13 Feb  2 12:44 modprobe -> /usr/bin/kmod
> lrwxrwxrwx 1 ldmartin ldmartin     13 Feb  2 12:44 rmmod -> /usr/bin/kmod
>
> should had been e.g. depmod -> ./kmod
>
> Simplest fix without resorting to calculating the shortest symlink is to
> assume: the symlinks should be in the same dir as kmod, just like if
> they were not symlinks.
>

I'm not sure I follow, can you elaborate what is the issue?

Are you trying to use/run files installed in DESTDIR directly? If so,
that won't work for a few reasons:
 - kmod does not link to the in-DESTDIR libkmod.so, admittedly one can
workaround it with LD_PRELOAD/LD_LIBRARY_PATH
 - kmod tries to open the depmod config files in the normal
non-DESTDIR locations

> diff --git a/Makefile.am b/Makefile.am
> index 39a46f4..6df2f60 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -113,7 +113,7 @@ install-exec-hook:
>          fi
>   if BUILD_TOOLS
>          for tool in insmod lsmod rmmod depmod modprobe modinfo; do \
> -               $(LN_S) $(bindir)/kmod $(DESTDIR)$(bindir)/$$tool; \
> +               $(LN_S) ./kmod $(DESTDIR)$(bindir)/$$tool; \
>          done
>   endif
>
> does that seem ok squashed on your patch?
>

I'm not a huge fan of using relative symlinks, especially if the tool
is run as root. In my experience that makes things harder to audit and
prevent accidental breakages.

As an example, my Arch box has the following:

 - /usr/bin/init -> ../lib/systemd/systemd
 - /usr/bin/ld.so -> ../lib/ld-linux-x86-64.so.2
Hmm should probably see if we can change these and how many things will break

 - /usr/bin/lirc-setup -> ../lib/python3.11/site-packages/lirc-setup/lirc-setup
Modern practises are to have a shim in /usr/bin/

 - /usr/bin/slapacl -> ../lib/slapd
 - /usr/bin/slapadd -> ../lib/slapd
 - moar slapd
Hmm what is openldap doing on this system again


In other words - I'd love it if we don't use relative symlinks if
there are other options.

Thanks,
Emil
