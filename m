Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE5B224252
	for <linux-modules@vger.kernel.org>; Mon,  7 Apr 2025 23:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744067201; cv=none; b=Vo7rXqFYMBYYTb0Mdf4qC2eo1XmBtbhXqtVCRj6m24YWRomyj+pPLOLqX7w+56uxHx8EbR3UTJ+4ZHG4yQSHyN4SUNlZFls1rI/A7G8A5kjxdVtoOGCLn72XqXtgnYJ2eobZDvBuqQN11aoH9SKjR9dcXnsciGZntYrJjPpyznk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744067201; c=relaxed/simple;
	bh=NnpMR//R+lE0HzsOk3Sqk4S2BtKa0vwBWH2sSUWKfnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSfSyPW5Gnz12RIZ+d7F+99n614zetLbDz7kugel2lfuct3W0mwEQyhxk8T18UAML/8r3fYjv/TGZC3TgVMdcKI4ugkkSfCiRwBPvtNUp/hhOeEfNx70cQ96XMUP0Uqgi8eQtGf865XEzvNkFJJUe+fDmbLG1GuhCEJ8CcXKeHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4WhjCcnt; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4WhjCcnt"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so4639a12.0
        for <linux-modules@vger.kernel.org>; Mon, 07 Apr 2025 16:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744067198; x=1744671998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6ZU8/5kXxHvtLmBpOqeu36t6PMkH8wk6iaMboo1oUk=;
        b=4WhjCcntCPmbLzJzbDIej7JAeA5fafx5VCkpzzUGcGsNq0A3HgH6sPXczPvkJB222L
         RQCSflsLL0rDyz5lj1AJ8ZUEuGLR7Yc+10hiBI/3C9VJVq9sQe2ZIYX8uVyqbPGTC+Mj
         MaTK9RbSFi0krpzV4KXEfAdwrVHWDx+1BicZ0mXecivSilcVKArkQ4XqKxd19s5q3uDz
         bXvRwdZeTclQJmRf8iWuuoga9TJNhjxr8BSUxL+jKEWvfu3Aty5JYFmJypsW311NN3s5
         5IAVWnBIK1nN0EnDVq9fZl9TvIbU7jovQNKFBzG8+UeGTpEYdkEkZysj6Z6ns+i5Xu2g
         5x2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744067198; x=1744671998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6ZU8/5kXxHvtLmBpOqeu36t6PMkH8wk6iaMboo1oUk=;
        b=Wg4cec26Uouf1hIAux7rCJwaUJSLZCrUwJFxGC+9OK0YJn5tCmJ8YMsji67mA40/h/
         eV5HLBv5aZ77+dUGxG2L+osBwalFMp2oRie2MSF0mk9Ojwr6KuFCRDRRZ9ag6ahOETZ+
         h1uvx+ME8q15DEcDIH9cAqPQwkwngDTm7EKzEWyZUVm5mbarVCCdlw4oAO0ui0bhr9DK
         sFccJa65CjKMRC3E08GDQRfGBWnRGb5abyRaggH5YvDWwjsrrMgVv9AR111gQ8aIzXI8
         CAYtBTTzqZc/e30Z1m7Ihbm3cKuBi5yHQ7ackm4Z0mjdLrrYDYdG6QtyRSlA3HEZcYXd
         XPiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc70yseJDmTtQJZHDIj5DsYGd4omDEmQIiyX5xx9A1rGflABf6+D3PO4Wen66058Zd57rNBw47vV8q2VfU@vger.kernel.org
X-Gm-Message-State: AOJu0YzhDvJ4YUo9BcbH7hzNZTNhaUgc46+0b53hrYMgwsyicpVTlTXn
	gPkZmZWXD6XZyFiv3srDgK50Zq2I1AFCLWKFjHKmu70Btywph2zT47y8WoeyBxsc9eTzNcGxNtG
	TGIkWze5Se093BIZ+QkEb/tXHl+X9A+1AAUCk
X-Gm-Gg: ASbGncvf8WwLauSPpyovbozy2tZJWTGHhIGJQkCAL6B+OTcxHwyFYkNIN8a8ZY5lP+p
	PliEemTICjMPn+hcxPHTKC23BYj0fIUmXn1Mh0fMYx4IY5K4NgIfvJuj9Jll5SKvLIUI7hF0p7J
	ivgItbaL5wFzN7nus8Z2aeJfruT2lNK1cEHRRTJnuocMYkQUmLIP/Wig==
X-Google-Smtp-Source: AGHT+IGwqCibUtvZ7zXUKoLw/9l4mbZWNa3k4PRsHBInjoFnc3gA8HPUr5aBeYPf7FZ1MhHrVbTftQ1BznakccCAUeY=
X-Received: by 2002:a05:6402:8d3:b0:5de:c832:89ad with SMTP id
 4fb4d7f45d1cf-5f26a698aa5mr22942a12.6.1744067197193; Mon, 07 Apr 2025
 16:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320232757.2283956-2-samitolvanen@google.com> <CAK7LNAQ8t-O2Y-47MEQA2cPYKq2NB+FURbZ8zJKWgT0grG90rQ@mail.gmail.com>
In-Reply-To: <CAK7LNAQ8t-O2Y-47MEQA2cPYKq2NB+FURbZ8zJKWgT0grG90rQ@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Mon, 7 Apr 2025 23:05:59 +0000
X-Gm-Features: ATxdqUH8gwXDjnSDaoNdK4s6L04JtZ--H42vGnrNEIhr4DeJpws2XPsHyTPSZa4
Message-ID: <CABCJKudb3GVL-nfUvd=1rhyH_ZWnxQCQkZBdGXQ16pA5fg3yng@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Require pahole >v1.29 with GENDWARFKSYMS and BTF
 on X86
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Pisati <paolo.pisati@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

On Sun, Apr 6, 2025 at 1:21=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> On Fri, Mar 21, 2025 at 8:28=E2=80=AFAM Sami Tolvanen <samitolvanen@googl=
e.com> wrote:
> >
> > With CONFIG_GENDWARFKSYMS, __gendwarfksyms_ptr variables are added
> > to the kernel in EXPORT_SYMBOL() to ensure DWARF type information
> > is available for exported symbols in the TUs where they're actually
> > exported. These symbols are dropped when linking vmlinux, but
> > dangling references to them remain in DWARF.
> >
> > With CONFIG_DEBUG_INFO_BTF enabled on X86, pahole versions
> > before commit 9810758003ce ("btf_encoder: Verify 0 address
> > DWARF variables are in ELF section") place these symbols in the
> > .data..percpu section, which results in an "Invalid offset" error in
> > btf_datasec_check_meta() during boot, as all the variables are at
> > zero offset and have non-zero size. If CONFIG_DEBUG_INFO_BTF_MODULES
> > is enabled, this also results in a failure to load modules with:
> >
> >   failed to validate module [$module] BTF: -22
> >
> > The pahole commit that adds 0 address DWARF variable verification
> > was merged after v1.29 was released, so later versions of pahole
> > shouldn't have this issue. Require pahole >v1.29 when GENDWARFKSYMS
> > is enabled with DEBUG_INFO_BTF on X86.
> >
> > Reported-by: Paolo Pisati <paolo.pisati@canonical.com>
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>
> The issue occurs with
> 47dcb534e253 ("btf_encoder: Stop indexing symbols for VARs"),
> then fixed by  9810758003ce ("btf_encoder: Verify 0 address
> DWARF variables are in ELF section")
>
>
> Perhaps, does it make sense to do this?
>
>  depends on !X86 || !DEBUG_INFO_BTF || (PAHOLE_VERSION > 129 ||
> PAHOLE_VERSION < 128)

That's a good point. I confirmed that v1.27 works fine too. I'll send v2.

Sami
