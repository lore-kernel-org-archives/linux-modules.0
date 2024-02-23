Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2D663110
	for <linux-modules@vger.kernel.org>; Fri, 23 Feb 2024 11:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708686165; cv=none; b=g+UFdHFrteLSE6xnMycYUKAn+465kqwnUzjIzO9PWZ/fIpU1Gt7VhYdXQvxBtFqd17VkB4nBfogb9xr/IiQRb/x6IqCBElH0VkIJnRr3bwJSdDJH66F0MqcfoDwMM+9H8nQ7CqJkFP+HSWRP8V/fufg83bmaOstZDQduOLyBskk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708686165; c=relaxed/simple;
	bh=KESqmMTru1wnd5i2x/8U6noCcwRvSwfSv265Bf8QwNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQLKKH3WOi2Jw/HbumuUROjTsftdLFxa15XVgXph8Si/nRnLwa22wfaJQr9DlHq5wLL7/qzKBT/NLU25d7nqH85flFFkbilGUvL8H7L0SZYjoBe5vODwZSinS1JA7KeWIuVg2vPrqu2Kf3z2eQF9EeMYgggI80Ld87ZgidYYUhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kun15UJb; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kun15UJb"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcc4de7d901so209448276.0
        for <linux-modules@vger.kernel.org>; Fri, 23 Feb 2024 03:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708686162; x=1709290962; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GVtZ3z0yASjQWQhffmmmm+1Hp7++jvO3BXrWUstMIfM=;
        b=kun15UJbsnNhXsYx7M6I3DhiGuFb87G2EMMj2Y++7zYsKXrGYMs2urGSIMJfhLNB+T
         Q1o77zujA6pwwHoXNdHOpHEi0osbVYUQaLQe/gRbWjpiHS010i+5/4skjF6Y/Npiz4nN
         joxpGLUiv8qKDNKC54oEqJcgamlOW6W+kUsRFdC8z69Mb/epQSRRaildEKGJs+IyF7g9
         mMXjbGYG3PC/Rh5bQS+xDT+tZsLcuC04PxJABPlkWMfAnP6BlkYz1XRNWrGFzBvoe9L3
         DATc5VuxplblonMfDKMslG3rP0XxavhaNGieKLqe3CYckceeV3AjIcXee6MJFZLHFv0D
         XzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708686162; x=1709290962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GVtZ3z0yASjQWQhffmmmm+1Hp7++jvO3BXrWUstMIfM=;
        b=sLRI96gbm5FVFam4B0uDUJL3J1okp0zPyRoG0bov4G804oGw6TankQnJ7H9Sr/3U/G
         LOY8OqxfQ54EEfc+iyQkvQSM4q2pn4hz5G4QoH3CukSgKAiVY3BD27xVBGRqnOlb+2WD
         cyDlOuOnTbnzSNdMcjFY8ewxV6HwjE8Jd0z5cR1ZqC6Nc5X+4qiz4+/NUfmfzm4AWal+
         kXqH+GfX1qnYFhkuqvjzjU/boLXJ+lB3mL1ZFhwH1oPp+AqvJC+hoBt+FENMyIqXUzIk
         8O5PJRg6gXB6o1SaBo0xOyROUyV0UDaJvLms43v56oE9FFM5YJoCs8HXEPL4QmXBvPGO
         20wg==
X-Gm-Message-State: AOJu0Yx+Igpjph1zU7xgb73V2M8nxwQzl14wEOahmx5tKkV/B84hoeWC
	Lgp8oH9ebdnhal4XQDm35PdeyIcFwh9t2cznQMuuTpNTqJAcMnuAXK7lU7tEae9jjurWeH4d1js
	OvGnQY9ftdNKraKRO+Qpu2jReabq/9naK
X-Google-Smtp-Source: AGHT+IHaE6z7sbLyoUPoZe4bnBYbEQH4mwefQASgRYlKgl3MqPU37hS9aniQ6ojk02LVOAK9aJWArNzGCFDVJdZRwrI=
X-Received: by 2002:a25:9781:0:b0:dc2:2608:af74 with SMTP id
 i1-20020a259781000000b00dc22608af74mr1582174ybo.26.1708686162111; Fri, 23 Feb
 2024 03:02:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212-rm-experimental-v1-1-b97ab3004ae3@gmail.com> <atgsidczvtqibln2fcupk6j2elwdiwouewmcaltfj36etxdudb@unbhhawe72yx>
In-Reply-To: <atgsidczvtqibln2fcupk6j2elwdiwouewmcaltfj36etxdudb@unbhhawe72yx>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Fri, 23 Feb 2024 11:02:30 +0000
Message-ID: <CACvgo53M6pSZznw=JzX3q_NvLVRAhoZtj=dNbHEiMw8gEZfE=Q@mail.gmail.com>
Subject: Re: [PATCH kmod] Remove unmaintained experimental tools
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Feb 2024 at 22:11, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>
> On Mon, Feb 12, 2024 at 05:07:57PM +0000, Emil Velikov via B4 Relay wrote:
> >From: Emil Velikov <emil.l.velikov@gmail.com>
> >
> >The kmod insert/remove tools were introduced back in 2015. Since then
> >they have recieved zero attention, unlike the insmod/rmmod variants.
> >
> >Glancing around - neither of the following distributions (Arch, Fedora,
> >Gentoo, Debian) build them, so we're safe to say they have no users.
> >
> >Remove them and alongside it the --enable-experimental toggle, which no
> >longer controls anything.
> >
> >Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
> >---
> >With the recent removal of the experimental and unmaintained python
> >bindings, I've noticed that we still have the insert/remove tools.
> >---
> > Makefile.am                                        |  16 ---
> > configure.ac                                       |  10 --
> > testsuite/.gitignore                               |   3 -
> > .../insert/lib/modules/4.4.4/modules.alias         |   1 -
> > .../insert/lib/modules/4.4.4/modules.alias.bin     | Bin 12 -> 0 bytes
> > .../insert/lib/modules/4.4.4/modules.builtin       |   0
> > .../insert/lib/modules/4.4.4/modules.builtin.bin   | Bin 12 -> 0 bytes
> > .../insert/lib/modules/4.4.4/modules.dep           |   1 -
> > .../insert/lib/modules/4.4.4/modules.dep.bin       | Bin 58 -> 0 bytes
> > .../insert/lib/modules/4.4.4/modules.devname       |   1 -
> > .../insert/lib/modules/4.4.4/modules.order         |   0
> > .../insert/lib/modules/4.4.4/modules.softdep       |   1 -
> > .../insert/lib/modules/4.4.4/modules.symbols       |   1 -
> > .../insert/lib/modules/4.4.4/modules.symbols.bin   | Bin 12 -> 0 bytes
> > .../remove/lib/modules/4.4.4/modules.alias         |   1 -
> > .../remove/lib/modules/4.4.4/modules.alias.bin     | Bin 12 -> 0 bytes
> > .../remove/lib/modules/4.4.4/modules.builtin       |   0
> > .../remove/lib/modules/4.4.4/modules.builtin.bin   | Bin 12 -> 0 bytes
> > .../remove/lib/modules/4.4.4/modules.dep           |   1 -
> > .../remove/lib/modules/4.4.4/modules.dep.bin       | Bin 58 -> 0 bytes
> > .../remove/lib/modules/4.4.4/modules.devname       |   1 -
> > .../remove/lib/modules/4.4.4/modules.order         |   0
> > .../remove/lib/modules/4.4.4/modules.softdep       |   1 -
> > .../remove/lib/modules/4.4.4/modules.symbols       |   1 -
> > .../remove/lib/modules/4.4.4/modules.symbols.bin   | Bin 12 -> 0 bytes
> > .../sys/module/mod_simple/holders/.gitignore       |   0
> > .../remove/sys/module/mod_simple/initstate         |   1 -
> > .../test-tools/remove/sys/module/mod_simple/refcnt |   1 -
> > testsuite/setup-rootfs.sh                          |   2 -
> > testsuite/test-tools.c                             |  71 ----------
> > tools/insert.c                                     | 128 -----------------
> > tools/kmod.c                                       |   5 -
> > tools/remove.c                                     | 153 ---------------------
> > 33 files changed, 400 deletions(-)
>
> error: cannot apply binary patch to 'testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.alias.bin' without full index line
> error: testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.alias.bin: patch does not apply
> error: cannot apply binary patch to 'testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.builtin.bin' without full index line
> error: testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.builtin.bin: patch does not apply
> error: cannot apply binary patch to 'testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.dep.bin' without full index line
> error: testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.dep.bin: patch does not apply
> error: cannot apply binary patch to 'testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.symbols.bin' without full index line
> error: testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.symbols.bin: patch does not apply
> error: cannot apply binary patch to 'testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.alias.bin' without full index line
> error: testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.alias.bin: patch does not apply
> error: cannot apply binary patch to 'testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.builtin.bin' without full index line
> error: testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.builtin.bin: patch does not apply
> error: cannot apply binary patch to 'testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.dep.bin' without full index line
> error: testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.dep.bin: patch does not apply
> error: cannot apply binary patch to 'testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.symbols.bin' without full index line
> error: testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.symbols.bin: patch does not apply
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
>
>
> something is wrong with either b4 when there are binary patches or in
> your git config. I applied the other hunks and removed
> testsuite/rootfs-pristine/test-tools/{insert,remove} manually.
>

Sorry about that - will fix this for the next round of patches.

-Emil
