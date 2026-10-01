Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E6D30C35F
	for <linux-modules@vger.kernel.org>; Thu,  1 Oct 2026 22:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790892163; cv=pass; b=Kxiulbp9jb0v8W5mh18sDKVnA1BEgm87x31TxlVZ/7suIEOz1d4MHe65123DVOkMR1leIb+yNJ/0igi5Nc0Nh0HytcP2NvHgXT6KgNTNS6GYbwvg0tt2hB+p5hnsFHyVZcL3/Pznf1WR4q/niP8PD5ijIHOPDNtxTd3yiYQW4uM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790892163; c=relaxed/simple;
	bh=/dIIozle01F2TP5UAfP90kLzrnuXniZTjSv6hVrVNdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQVi+BmzUE/3l1NHF0ZjwLquZMpS7+8xiXM2su+bhVtjKW/PSVOhrNk6S7t1o1wTCVn6Rx8P67WYhZnz4eJ1pIifpgv3wpBkCcI6K385O1VAvg7OCEeAwM2M3UWKR+9oMgcA5Cu+i3duFvGKav3CkG3shF2tqQIHSxI35YWvN0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zo95PFl1; arc=pass smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zo95PFl1"
Received: by mail-yx2-f41.google.com with SMTP id 956f58d0204a3-675711754ccso2868282d50.2
        for <linux-modules@vger.kernel.org>; Thu, 01 Oct 2026 15:02:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790892161; cv=none;
        d=google.com; s=arc-20260327;
        b=sWQL3tdP+Tvml04wcmeBcz/JlXQMLFk4w/k/o+g/uk5bzwiZR5FNUihXbe0fa5pRCZ
         rLJdsPnH8viuKhO4jcvZb3J05BZSiy3Rq3IbcOpEFEZGMhyst11ykTWHYSKvEp98SHd1
         SlMYF69G2j8m0zxM/Lp5dAWVsMeczvQ77ipM/VmctlYaKskotO1IXSuC1nVPomt73Ift
         w8gIF3z5VrmxLtCwQg/D9/0tRqkxHSJdSShuhNOtaPnHbNrfW8Kf173HQi8rhMBAbHlK
         lEFVS5yl9La/2WN9pbISAoz0jIwBgXQ64ONQ85ZIXg5WJNP/tuXv6GuL0aGreU7H2I6p
         WcIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fqM5uspbbFzV6bdXwPQ6MVvrUI0lCblX7jHB4nRMB9U=;
        fh=5cs6b6d7Xpq2ANmcE1sW6J73OLOoOdfaXy4E0BsYxz0=;
        b=PqCX3ByOdSO/eqqhz4yLVOM5YDcPo4IYNIopBVnUf2Px++sRAKcAFx8qWwnxO1XmfC
         r0sEIfSelykUubsP+PUTr5kpDAt4ufDEqb2Dh1g4e/S0NFhN4yz4pnWD1JqN+9/CuiCK
         E2cq9N3HwhOPCqS+3ojzJZ52IRHNcJG6PGES6LkVlHtmN6l72GkgAiupaiio1/tIeWrh
         52wkj4TKZI/2tO+wI1IsXtVy/Ye2z4sl6eYXSOyTqkXkbqzwcRvV6QhKjEWITXAQ9yCu
         e4Nj7O5cSENimDWsVlNnO2hTWpKeTU/xaJHOjo2lswOYfDQKjN2v9uYFqEf807wS2XoE
         xdfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790892161; x=1791496961; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fqM5uspbbFzV6bdXwPQ6MVvrUI0lCblX7jHB4nRMB9U=;
        b=Zo95PFl10DoYMCMK0ISsiyDJ+NpxxOGJxKaU6fflEr+m4d/QdLSuWk6H72qPRayAcK
         MJfjJl2ADZLvIYNEg4QlNS9dg/mnzb+8Ye20pOLFH8IiQmofBYaVY0Kq9FbDo/MqOjhj
         bJmm06JBhk5mqdHVZ69b8GYpNohNjl8WXk8FFbJzYT3IYa8oRSs8UTpxKq0FW6o7Mut5
         wGpJraRwQhZS8ExbdLNWBBSwjJRC/RdWTxRlkwB3ixULc/FtmrSN2rtWSoCziHaJPmeY
         TVvka1NlJFF7ho4Om6p+c5bZFyUp681zEs2PuHH3BEQcDbPx095q2sTWNYN+DeVs/Y4c
         CETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790892161; x=1791496961;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fqM5uspbbFzV6bdXwPQ6MVvrUI0lCblX7jHB4nRMB9U=;
        b=Hi6h9emxoqedjLgzsbEvrW3VugajXP40Mwe3B/P4wWuYdlJYCcFd+nmq1Z967DZgbQ
         IUveOjzp7tk7gr91RIOhO74xZ65OT3pHzCtTzM887YjalJalXbDzC8swlI8XNxPkbfrx
         sxPDWjkCTodQSTE7H7h0QTxWcZgOtG7Qu/ke5dZC6XYaVVayyEl5mNBK61oHnIJheZjK
         EM9pO+/ojuF9nOrao2prxfM20mYnLMahXqJDQL36xzOAeqqic7V1gngR5OhIoBH7As0i
         ZLCuMTitkOsK5q5RvHApWRowTKn26BUNSGAvKx1Ig1xmuuJ2qNZjv7WGCzXSz67yRRhm
         VGiw==
X-Gm-Message-State: AFq9FYK2YpWG8Ov3GZgthXgkVs3UHy4qrjJ0tb6nrN1Vci2mY2hMPsNa
	1PYfhMQsDNYWzg+pK9rHowb+9iJYOmrhGLI64F9YjpZNJg7np7Qr54OaLAo4W0S8YMshXyM8SMw
	XiZ6FP2SQ1w1fqONGCIHKVLE7wlYL75mgqxVo
X-Gm-Gg: AYBFou3r5DC/3g73qhRiY7/3DHrDUx+R8eShb73cRqn6xmATBBLfedAgih0SRQy9poF
	lFMF4oVaWvshzNrv2FNIxxdccIEvj+FzYsl09h39BRuVJSft0ReluXeZ6jDYCv9Hp6MbhR4nb7V
	meP7FBCk7q+vycHf8iEllYteN6fTjY3KpaMSAj3eWNxWyaQidT7eJbH4GuhOtueYg83worP/XF3
	sfrjJhPeVxdbPOtCJ77BHJ5ngmeAL/Glvga6mJLasAtzLpmkdNgilfFngNA5hHT+2obaIok4zsS
	RjR8ne06WoXDub0Oh+zoVaB+LBGkq4l0O1YkIGVFOXDHf7W/kLG1rtkEVAw+1TFwzsSQ5AvtCkI
	Ucj795VGCAa50NQIoJSIrGb/pGxAvoaPTvQ==
X-Received: by 2002:a05:690e:438d:b0:671:1bbe:f68c with SMTP id
 956f58d0204a3-677ac03e975mr192565d50.51.1790892161398; Thu, 01 Oct 2026
 15:02:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
 <20260923-dd-cmap-part2-clean-v11-29-9b6c217fdf2f@gmail.com> <20260923224657.3F5C71F000FF@smtp.kernel.org>
In-Reply-To: <20260923224657.3F5C71F000FF@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Thu, 1 Oct 2026 16:02:14 -0600
X-Gm-Features: AclHuK8ODmvd4WyPoy9OINszBNVr-POspB9wdJcmt3RssLX_jouSGEmCCu5Ssb0
Message-ID: <CAJfuBxwYku+xUmWVG2-BhqKCeb=-=B6d9cdOJ9vf73NtBq=sdA@mail.gmail.com>
Subject: Re: [PATCH v11 29/38] dyndbg: control-parser: treat comma as a token separator
To: sashiko-reviews@lists.linux.dev
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 4:46=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] dyndbg: UAPI break for unquoted commas in queries
> --
>
> commit 3647cd55c26b2f7588078b414e3120a9276258a8
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> dyndbg: control-parser: treat comma as a token separator
>
> This commit updates the dynamic debug control parser to treat commas as
> token separators alongside spaces and tabs. This is intended to allow use=
rs
> to avoid shell quoting issues by substituting spaces with commas.
>
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index 8eef2e7387a98..6482fd28def46 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> [ ... ]
> > @@ -336,8 +344,8 @@ static int ddebug_tokenize(char *buf, char *words[]=
, int maxwords)
> >       while (*buf) {
> >               char *end;
> >
> > -             /* Skip leading whitespace */
> > -             buf =3D skip_spaces(buf);
> > +             /* Skip leading whitespace and comma */
> > +             buf =3D skip_spaces_and_commas(buf);
>
> [Severity: High]
> Does this introduce a UAPI regression for existing unquoted queries that
> contain commas?
>
> For example, if a user currently submits a query like "format a,b +p" via
> the debugfs interface, the parser would previously see three tokens: "for=
mat",
> "a,b", and "+p".
>
> With commas treated as separators here and in the loop below, wouldn't th=
is
> result in four disconnected tokens: "format", "a", "b", and "+p"?
>

Treating comma as a lexical delimiter alongside space and tab is an
intentional grammar extension, explicitly documented in
Documentation/admin-guide/dynamic-debug-howto.rst:

0. Comma separation exists specifically to solve shell and command-line
   quoting friction in space-hostile contexts (boot command lines and
   modprobe args like "modprobe drm dyndbg=3Dclass,DRM_UT_CORE,+p").

1. The dynamic debug grammar rule is uniform: any argument containing a
   lexical delimiter must be quoted. Spaces inside format strings have
   always required quotes (e.g. format "foo bar" +p). Because commas are
   now full token terminators, commas inside format arguments must also
   be quoted (e.g. format "a,b" +p).

and the user is free to add the quotes if literal "a,b" is what they wanted=
.
    #> echo format "a,b" +p >control



> >               if (!*buf)
> >                       break;  /* oh, it was trailing whitespace */
> >               if (*buf =3D=3D '#')
> > @@ -353,7 +361,7 @@ static int ddebug_tokenize(char *buf, char *words[]=
, int maxwords)
> >                               return -EINVAL; /* unclosed quote */
> >                       }
> >               } else {
> > -                     for (end =3D buf; *end && !isspace(*end); end++)
> > +                     for (end =3D buf; *end && !isspace(*end) && *end =
!=3D ','; end++)
> >                               ;
>
> [Severity: High]
> Because the parser now explicitly stops at commas within an unquoted stri=
ng,
> existing queries containing unquoted commas will be split.
>
> Since ddebug_parse_query() expects an even number of match-spec tokens
> (checking nwords % 2 !=3D 0), won't it fail and print "expecting pairs of
> match-spec <value>"?
>
> This would break automated scripts or user commands that pass unquoted
> commas in their match arguments. Is there a way to support commas as
> separators without breaking existing unquoted comma usage?

again, if theyre looking for "a,b", then they should quote it.
just like if they were looking for "a b"

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-dd-cmap-=
part2-clean-v11-0-9b6c217fdf2f@gmail.com?part=3D29
