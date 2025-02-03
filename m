Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A84520A5C6
	for <linux-modules@vger.kernel.org>; Mon,  3 Feb 2025 14:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592970; cv=none; b=bcpyCGH1JTIEIDuMcodCifoc/XMSL6hMVY3kzN96ASjd+OOhybXvB3Pq1yOD5ZHxwV/RtpDdZ9ZleZ0WWsvnOhcRdFwnrRbeaNWeTRoFijNozxPGpecxGtSrhiMpM8yUYN5966L8Ap+cVqQX6lyiUyKsnh1etPN3VxiTSS1FSDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592970; c=relaxed/simple;
	bh=9m8yHZ/xq5yo0/XbH7/aqq4u9pNGQdOz65IFgXD4ngc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oWS8flCFJ3qpFc0j/cXBJTs3behTy/xXIBNKQqYxPv5RaMN51yXRaeup9tuBfqrF2rGkHetpre09k3TfFTtsIe8xMPRCaohu9mNJ78+Y3msv8Khhya/sDspl4TGXcalx/+DaXosrY+UUThSTsbGhYaPScfqmAzjQu9SBqUzeREE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hujdu8R1; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hujdu8R1"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f83a8afcbbso6533780a91.1
        for <linux-modules@vger.kernel.org>; Mon, 03 Feb 2025 06:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738592967; x=1739197767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TXQsubBdw/wAjD+eExfN+6DFOSabStRe5P1g6XNmoc=;
        b=hujdu8R1O9qNpsdzrOwHRxOLXPMH8DJ2d56btPrYgLT4SXT9tq0Hxh+lusm+N3tj+f
         Wk0xieV8S0ZMAVNfq7gBnIP3NiOmJBLPhA8WGS5CG0geKQbgXDqaF/ajB2gqK5Mb6pOp
         +dD9edusYeci/0WMQcGINbocDf+Vih26X/wCS44BVJTGTHR59QxBIWrWmaGEbCSWqZ+1
         TAU80zW/o7Ro9ELvVNKTk1Ft0rfRfi24AA1RFhbYLF9rIEMLo0Q01RLt1djmBgFktunz
         WeChDkNI8pdKNVxUwvojnAPnrzx2wzPOeXE0DeLMUrq1909YDBvvE4DwaRYBk4Bq9nnC
         uhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738592967; x=1739197767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7TXQsubBdw/wAjD+eExfN+6DFOSabStRe5P1g6XNmoc=;
        b=u/0R2C+4LKD82tKUbEN6wQkmxT6q+8zqUWrOjblqV8NJek/jXAo3i1OggFm33wo7iE
         7Fih39yMwNfsD32Ov1k4Khq6qvXbfRc7pIeLaJKCCaV+lxYdH+U42ANawOXZgkAEaEKm
         KuV8m+KufDerMeo9Y9F+veVu9fAuLilFxt3EK1X93uEpubntU0YvMtHotj+Ld3wftIbu
         jpEjqHT911r7LiQYOfv45ZgijVN7+S7IHM9lZ3bcvVmboozNskerjiDOfwGpSx0EfJng
         kyx90qrwu5HVsRZE775VbAbXnybiRZVKfDZ4JuXSoKdjQlDMMX6cM7M9GPDQm6rGp8jw
         fHpA==
X-Forwarded-Encrypted: i=1; AJvYcCX7Dzpdp/OEzFhKnS0fM6mrWFR9cntu/CESXlsPWLtv+uDp2igHJx/TveVm2SlbWlvNgSL2mRn0fCX22ocU@vger.kernel.org
X-Gm-Message-State: AOJu0YxFPBvgEzooEzlEOm5P6+MYlqoXBWLSLv0QwKYrzs/DL97ZCZix
	gfPTL0HUkiBJzwNNbRMtl7pLzopnkNmiEKgw1lvni8we1FR3W+UYPrD9MfP88sKkpVlxrgLX8Ml
	J2JKjeQUMVnTSxLHedw59NignyergwnZwtcWI
X-Gm-Gg: ASbGncsuJH5yGmeRTZz/sG16Hrn+b2kfDtzB7L2LERxosWDE5EDrfxpwEUf9jr+7ALD
	Ow08uB+qc2/DKUvWr7x3Uic1gGScm7QZ3e/avTFvXnI6H8DMIuZtev7INxctp3ViWh49CxQZvXa
	OE6x+sS/gjUx4VLJUgsZ5nOHpB6f4=
X-Google-Smtp-Source: AGHT+IHTruQTFbormYFeQIcy728mYS1bfRzzv7IZB7Q85ek/7/F4gYieXONEtPMPRoQtGfxVcz+ogIq1MUlcUYn+3Jo=
X-Received: by 2002:a17:90b:2dc9:b0:2ef:2980:4411 with SMTP id
 98e67ed59e1d1-2f994e6d108mr20498323a91.9.1738592967383; Mon, 03 Feb 2025
 06:29:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <679b7c95.050a0220.d7c5a.0014.GAE@google.com> <CABCJKufpND1qvBhUMwpJ4OE7Umo9EuaNTLOi-GmAXFdXRqhoFQ@mail.gmail.com>
In-Reply-To: <CABCJKufpND1qvBhUMwpJ4OE7Umo9EuaNTLOi-GmAXFdXRqhoFQ@mail.gmail.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 3 Feb 2025 15:29:15 +0100
X-Gm-Features: AWEUYZkbZyGsg2KJCSYTFl4vhroH4GwPRZp3afld8aOLFnVjuqncctYVhB0Hf8s
Message-ID: <CANp29Y4OWo1ebuP=1B6O_Qhhg+YprW899s4PpEs4HVpvKs4+jg@mail.gmail.com>
Subject: Re: [syzbot] linux-next build error (19)
To: Sami Tolvanen <samitolvanen@google.com>
Cc: syzbot <syzbot+62ba359e1dfec1473c57@syzkaller.appspotmail.com>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-next@vger.kernel.org, 
	sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 5:28=E2=80=AFPM 'Sami Tolvanen' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On Thu, Jan 30, 2025 at 5:20=E2=80=AFAM syzbot
> <syzbot+62ba359e1dfec1473c57@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    a13f6e0f405e Add linux-next specific files for 20250130
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D10221ddf980=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D3445081dab6=
3716c
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D62ba359e1dfec=
1473c57
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+62ba359e1dfec1473c57@syzkaller.appspotmail.com
> >
> > scripts/gendwarfksyms/gendwarfksyms.h:6:10: fatal error: dwarf.h: No su=
ch file or directory
>
> gendwarfksyms depends on libdw, so on a Debian system, I assume
> libdw-dev would be required to build with CONFIG_GENDWARFKSYMS.

Thanks!
Adding libdw-dev has indeed fixed the build error.

#syz invalid

>
> Sami
>
