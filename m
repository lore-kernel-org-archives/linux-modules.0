Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832101CCEFB
	for <linux-modules@vger.kernel.org>; Thu, 22 Aug 2024 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724349482; cv=none; b=f4H71KlMzXqJ0UOwcpayE8OIVfFrorbHJlfgYcJojorl/gsgycY76sgJTQOZxhxVFYxVOssQk7OzPxIg0GzyR1pLQtqZoFtv4SRlOwOVc853+hoyOoDr17Ok58IRHDr/mcGcF75mYyCrv3DhfAoK1bsFr3lPysGaXkfbwJ/YMas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724349482; c=relaxed/simple;
	bh=AyQnYoPe6sf/wSyLAOYvZiLsLlNC/z1c6uDn8wvCjt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVgTyzSoUMBHUpNTBFYaOZbIi5QcE1M6fO2LApTJ2wYxgiLAzfccmAmhW6/HyVDBLBItXcTcGzHgw2Xpe4CrDeZc9OB5oATegmrdPJFCQNwRrIBQW2k1bH+oIzsUzieaA9jm9FDIdE3oRoVZgk6/ZIsnX50DNHyVPU2NR+Y0Y0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A0TnMeyY; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A0TnMeyY"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-44fee2bfd28so27491cf.1
        for <linux-modules@vger.kernel.org>; Thu, 22 Aug 2024 10:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724349479; x=1724954279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOajGVKCmpE5kmdw/T7Qp/wNBvNSdZEW8S+OXk3bvwo=;
        b=A0TnMeyYdHzSVj/b2HPYdhkBusch8SVI34fBwCpGSZbzyKirr+eshjNsd/eyeq1DmH
         oEr82q5XOSGB1/Nx1BGV2zQLPQlIgtgpFR1pZc/iXchTci7b68j1vVkIGq1uzemWAQw7
         hekHQKnm1CFInFEdfnZ5IOA/Z+sChhxSlyDv5rT/jTdD8P+xRkRAlrAlRJwEa2FFSirN
         vHVDlAcwUKdM3bd3GXaNoSv1CHgBKVmFyLN2QsL7RX7KF1f2EBLwd0bh8hMWDwuK3UUP
         xR3QqYAs+OYTHkxpYBIniCYr0vKfRzi3DFiIBdFhkOnhrr2vDJKE9fFiYcdeIBUaUajI
         nnzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724349479; x=1724954279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOajGVKCmpE5kmdw/T7Qp/wNBvNSdZEW8S+OXk3bvwo=;
        b=G/CoIYGcAlMzs0ggCAJVRGyIfUFk3Tj4rOr2rwPWSrI+SIY2vqyPy31ULmD4eejdEH
         U5Rn4Gf0g50NaPeHqDTvlXMShwGW+Q/7msfiR6DkfrJt3Wiptz5hjNf/m29IpJTt6/Vo
         4fIMbEPJlumi8yeUd3JxXnsYJvPXorTwK2I/OZkpjNXSLkD99VL6t54Hk5hm4KTUyxii
         pFeLUL4egMo9HigZNXxlg9TVkYsI+RDXr2u/SQSipSw2DGF/EBRMokG2DIQIBbhitqBN
         orp3aq6cpCjjQ7klx8ZIVfCfGxvpIr5wfVbnWY3BA2dwj982gTuq5KPSTAVBxV6AIPT9
         2jrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWam5k5ulq09Ytuqh1fxUiNo4YfO/KcM/sZdjJdqUA37VFOdA2CdqBvBSG8FVsPJmIQKuZ3kCTeZ8u1Z35f@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ZSVrNACTOWxXLXofG98iO47Xb6vWHHhCmimYOslobEX5ikhk
	SNPWGA3DuptqM/dUC2KrI413xxP05F0cV2wNHvofe+PWDziGjqih8aOdjasSXgJANVmCub88GJ9
	wqr3uxSDeD81lb+Pblz+ojjfHHeawUP/g1+zO
X-Google-Smtp-Source: AGHT+IHpOQGA1+Xvu8VfAIHeP2jPYfCEPVVyYq8ryHdwZRdhtAaz9lpYz6WE5A47PoBLoqFMm3zfFnuZRf1AcYxhCf8=
X-Received: by 2002:a05:622a:1b91:b0:447:e3e3:77c1 with SMTP id
 d75a77b69052e-4550859549emr27021cf.29.1724349479217; Thu, 22 Aug 2024
 10:57:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815173903.4172139-21-samitolvanen@google.com> <874j7ccxtz.fsf@trenco.lwn.net>
In-Reply-To: <874j7ccxtz.fsf@trenco.lwn.net>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 22 Aug 2024 10:57:21 -0700
Message-ID: <CABCJKud=YO=fxF_tmX1N2ec66Rzqh8RsaQu0qrbC5WB529wgWg@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] Implement DWARF modversions
To: Jonathan Corbet <corbet@lwn.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>, 
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, 
	Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jon,

On Thu, Aug 22, 2024 at 9:43=E2=80=AFAM Jonathan Corbet <corbet@lwn.net> wr=
ote:
>
> Sami Tolvanen <samitolvanen@google.com> writes:
>
> > The first 16 patches of this series add a small tool for computing
> > symbol versions from DWARF, called gendwarfksyms. When passed a
> > list of exported symbols and an object file, the tool generates
> > an expanded type string for each symbol, and computes symbol CRCs
> > similarly to genksyms.
>
> Potentially silly question but: how similarly?  Specifically, do the two
> tools generate the same CRCs for the same symbols?  It seems that might
> be important for users transitioning to the new DWARF world order.

Reconstructing the source-based type strings genksyms uses from DWARF
wouldn't really be feasible, so the CRCs will be different. The
similar part is just that we build a human-readable string from the
debugging information and compute a CRC from it. If anyone is
interested in switching to gendwarfksyms, they'll have to rebuild all
their modules too.

Sami
