Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5533F4116
	for <linux-modules@vger.kernel.org>; Thu,  1 Oct 2026 21:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790891631; cv=pass; b=nKpoGPzfsOk5rhb6mbnfuLghrl/aJJUn2tmM4RUhh3AvC7WS1fTxcGBHffLXJxG0F8mw34K9iK/KDjev09je0d0e81MeDU6xxe5ybdLbiMk1SbbQutB5Jn9hfA7T/zecsgoeUf5fbdHplfwkSCg06M+qk2qFnRfPM0Ahx1/nCuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790891631; c=relaxed/simple;
	bh=vA19tAGIJDqPrBtiC/KKawxnc593Ufa0N0iSnBpRCWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HuG2PnbX7T+ztfGf5LlMd8xlkRJtek75GasyDHckqMrsia30MpPRP2PSPFZ+NbXtuTaPWcOfVBjzmIaKTQsxlBx6Q9BkNDZxI8yeI1zelPsdJyQb2UqAlltuI+AKC1g+Ri5Qnrmcmn7KG7C6po3EUSMGphbKpdvIi0KhAUoydoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4AUUEDy; arc=pass smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4AUUEDy"
Received: by mail-yx2-f39.google.com with SMTP id 956f58d0204a3-6768ac36eb6so2166299d50.3
        for <linux-modules@vger.kernel.org>; Thu, 01 Oct 2026 14:53:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790891629; cv=none;
        d=google.com; s=arc-20260327;
        b=dxlcMt4i5NXTZWabYKgVON2Ito/Dsx0rIvLjBhkK32T3kWHSxwauBZh2Ly0fuzNBPI
         B+kiNpeeFInNfKi39uVaMVU/Bi2thjVoQzi/OvoyKOvfi1CH9cXiGmuGHQTUNcMj6PkG
         s0acfxh5hW4POz343nTjBGzUasqWTrrfONt+6ybTeZWSk+kVzvD2KQUWQGQlRK1zO757
         8tqdDVjbZ7qodqSeRF8Tpkxs6ThcQqn4EMkcCbgj2bOvsC2qqvLar08I+/4G+55uul/I
         DQSs3NGnBJEKkuULPT1/8dCXJH0Cws64Na/sckAMLLUDTC+/HhvzwdkAlBzTBtrJAlq0
         /KfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=njBFBYHB/ygG0sy5bqGUdErgBk/nK08nFChwa26Lyng=;
        fh=5cs6b6d7Xpq2ANmcE1sW6J73OLOoOdfaXy4E0BsYxz0=;
        b=rFI4k6ZpOQGhxmkw5UpWk5VJwL9IxtE5tbaoRRZfXTZ8EXCmAXWxbfydbY2TEsPylY
         vquqBuNXvj4M2nufeYcTmhQHTqHuAAUhElSlRjdO6+eRmPYQz6BA/Rx2+gWAnhXs4HNo
         RN9YPK9guhM0BKqcCyv94UatowpYp43QUXAdg6G5BQsy3ksN6af9lJU8xDnbhXKuhUqE
         fU4FAWwGcEk/04kvTJlMkHX8Fd3eVCuY2KpnyinoPc3NQeanlnvveY3KGFvoicUcG3hA
         /2EJSABRlAH27xgvPlvI7EA/6J8OskF+AaUtbc90pFUmR9Bw1s5/G9B/xhG+sSES38rU
         CInA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790891629; x=1791496429; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=njBFBYHB/ygG0sy5bqGUdErgBk/nK08nFChwa26Lyng=;
        b=V4AUUEDyVM9lWyOs9YRgKFPbkQcIwrmahU3ERTUGHFIJJslEeRKRvoalVNTsdotTxu
         4ciLwLhpjJ65bgyjOhqIeb+J72CpOM0aXZxaHMGEvVpY4bazDUtJc49a9o8tUcKhI0cP
         02YtZFN+erHac1cqnYEmuDJpvB1rIFi8KEU60WsnBlFTtyMepR1FZ9HBKKd2HzeM+fDf
         vw8CK2hh02pR2UaLDcUacfBTvQuNCXXWgE7VODeX3X2AoYG0rzYt1mhkgfEDRMrBuD+8
         1F3mFzMWSOXgvvTou+gITHAIVE84+/5/Jja33a8S/djf6Joz/ZnT8JCnum49FuPZwWX/
         1QhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790891629; x=1791496429;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=njBFBYHB/ygG0sy5bqGUdErgBk/nK08nFChwa26Lyng=;
        b=i2ocmvV4vcCqGvfH8bSBYu4SKlfTkCr64V5/tE7A0/MCuKaN7U3hGt4NXBHXbmvWUx
         X8B/HtXAihCQBSbWTOY0bp4RTg2OZKXMSVNh3ImdrYh075yK4qSiQhtLVjMqxJY1PejZ
         s3nCydGIA8rWfe+llbmR5FIHe0IfYMu6HKc1VnoBFhf0erXiLsWw/igumjDTDVzqaPXo
         sTlIs3NfWMzZzm1p3/w51k+KVPfXs1DhRvj/mU+utNujqzc09sfcnJQ5ovzejod6MZ0K
         RaY4yxRSCTjriBJ0KKUwB+tVjcnPQL+8ck1jj745SHuxmWpRm4zkL7tS/bmMfoG/LFLJ
         f7vA==
X-Gm-Message-State: AFq9FYJxR1sS51ukr5o81W47snQpNzdyGBhnF4Ufw72FIqenbP0iDWij
	C6/ovT3agBSgWK+bPRcg+pajK55N7ebnNnuMIvaBoRlPum4Ai24P1FR2zCsl+/DaxOVCvooGnQz
	+puGr5h+zCWuZLdjYFWm0IhsEPL3KOK42rJmj
X-Gm-Gg: AYBFou0z8yrKVmJtVPNK47pC0+Wd+8VPZhWgKE990URTpCOSkr0Q1a6mkhbtKz37PFj
	/EdRpMQCoW7qUOsI0/kOoV81Y3N5DD0xxy3scXXggE/eKGMNDlwhUZ86m62s6WF6lyLE33lXPSu
	HsxFa448YYNwsxmLmxeAvmww7uUQ/HzznFKkXgQfKz3wTIUzCvW8Eoka+/CADq59NENfaxSbcWg
	N/k7tRCukdSzCAwC+7HyQF5t7+mjLAU64sioH5xoIFiMJtS3sXytu5XIxrpk5EPLyr3WiP3DkWe
	ENc4BKFheZtpmj+zWSLbPRyd3MIm+bGAHL1jUn5EOuAQGfuO3lVpwOvYCNi4U24pbbWuvVT3IpK
	8KYRw80MZpJ2bjbT3EHOe3CHid+dVmPBCXw==
X-Received: by 2002:a05:690e:488c:20b0:671:203c:2fd1 with SMTP id
 956f58d0204a3-677ac0f1326mr206768d50.70.1790891628567; Thu, 01 Oct 2026
 14:53:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
 <20260923-dd-cmap-part2-clean-v11-37-9b6c217fdf2f@gmail.com> <20260923225247.B92F21F000FF@smtp.kernel.org>
In-Reply-To: <20260923225247.B92F21F000FF@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Thu, 1 Oct 2026 15:53:22 -0600
X-Gm-Features: AclHuK-VhbFVr2q_qUQkOvb_sVHawA26J4kUVe6GFDVRsehq4ONG5tWwrqz5Ps8
Message-ID: <CAJfuBxw8O+=Z0TjGHDapnUZuu+ffkYsOJdyVPdPQBx7f9Uv1oQ@mail.gmail.com>
Subject: Re: [PATCH v11 37/38] dyndbg: add +c flag to count pr_debug calls
 without printing
To: sashiko-reviews@lists.linux.dev
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 4:52=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] lib: Kernel oops when modifying string literal in ddebug_exec_qu=
eries
> --
>
> commit 33851d8d7a58ba9b9a4cd975835feabf66d636db
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> dyndbg: add +c flag to count pr_debug calls without printing
>
> This commit introduces a new "+c" flag for dynamic debug to count pr_debu=
g
> calls without actually printing them, saving memory bandwidth. It adds a
> per-CPU counter for the hits and a "reset_stats" control command to clear
> the counters.
>
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index 88440c1f6abba..9b789287afe56 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
>
> [ ... ]
>
> > @@ -727,6 +745,11 @@ static int ddebug_exec_queries(char *query, const =
char *modname)
> >               if (!query || !*query || *query =3D=3D '#')
> >                       continue;
> >
> > +             if (!strcmp(strstrip(query), "reset_stats")) {
>
> [Severity: High]
> Will this cause a kernel oops when parsing module parameters?
>
> If a user supplies the dyndbg or module.dyndbg parameter without an
> explicit value, ddebug_dyndbg_param_cb() handles it by falling back to
> a string literal:
>
>     ddebug_exec_queries((val ? val : "+p"), modname);
>
> Since strstrip() modifies the string in-place by writing a null byte at
> the end of the processed string, passing the read-only literal "+p" will
> attempt a write to the .rodata section and crash the kernel during boot o=
r
> module load.
>

Confirmed and fixed for v12.

strstrip() calls strim(), which unconditionally writes a null terminator
to *(end + 1), faulting on read-only literals in .rodata.

Fixed by:
0. Replacing strstrip() with a non-mutating check in
   ddebug_exec_queries():
     if (!strncmp(query, "reset_stats", 11) &&
         !*skip_spaces_and_commas(query + 11))

1. Passing a mutable static buffer from ddebug_dyndbg_param_cb():
     static char dflt[] =3D "+p";
     ddebug_exec_queries((val ? val : dflt), modname);




> > +                     reset_ddebug_call_count();
> > +                     continue;
> > +             }
> > +
> >               if (modname)
> >                       v2pr_info("query %d: module %s \"%s\"\n", i, modn=
ame, query);
> >               else
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-dd-cmap-=
part2-clean-v11-0-9b6c217fdf2f@gmail.com?part=3D37
