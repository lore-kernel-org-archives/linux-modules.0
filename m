Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80522980C2
	for <linux-modules@vger.kernel.org>; Wed, 26 Nov 2025 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764165059; cv=none; b=FaMZU5Ss/yP3dmldYNQomtYBZkk6uQzwgNtNqsyQ7/KPBLRqYBskUzJe8UvqTRozlV004nhIsZJ6QI5pjbAPmmNUSLh9y4+FefygSduX5ltL5GHn6IEunajGi0CQpEESQ+29hr25QJAZcboEe1pY/OdlTPFQMNz7PpBzUZ7zTUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764165059; c=relaxed/simple;
	bh=hVlN1t05NF8J9hwZYP7yS3Hy93FFi7SiwUuqHtqtjZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HacckAD6+c3dycmFjwP7kz4YA3Y6ovttdiaQMiui8oN7I6t4+d9/b9t6632MkcqWD3VKSndSskAIpgA/UESHgLcMO4nHvCUW4IXLCcSQs4BrJRMTFc25NmmfiYuBqPXFRFuIFgDAYD/h/+rw9fCEUW2FAtFdjCQDVqXctt5uxFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7Js+X7E; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7Js+X7E"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-bdd38966c74so81647a12.1
        for <linux-modules@vger.kernel.org>; Wed, 26 Nov 2025 05:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764165057; x=1764769857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MubSNeMbmYM/HeKESQYTWsGeLQj4IZdr09nxlU7W7oE=;
        b=j7Js+X7ErECCEVCRHjIjKPkzMn6JHvMVeh4ajcPqdigB5UGGOrI1cSoDPW+4ehRI2P
         9+tAgl4TkqM0j474ntoeTjPt2uAYl/HLQEXfcRuZk/nvcRBdIedCFGFaM4ud28K5lGQV
         mJuESR/YoweA7RhyFYf1NMFPj//3bO/0C/qru88cF2/Q1iF/5kpGQdBPiBFnoyUTyTxi
         n/GZ9to8VutQi1I2EYK/71SbdvYvJ0RWtgVUQBPWfifiCb7s3t2/uRt+UxA9WNwIUOHQ
         xNvlnGgUOQHJNC5KeU8qEsNiIhzmwf0fk5C1nHYVzfECWLylem0OstbgzCRDVOxe1XJ7
         e2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764165057; x=1764769857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MubSNeMbmYM/HeKESQYTWsGeLQj4IZdr09nxlU7W7oE=;
        b=n71xEgOSxtwAm4FQm246Aom1Zxj7TSSYpZOZsgtXRveR2byxeh4K6EnL7Icita2y8H
         jAInwHpn9AgKfcO/oTUwzcN5aM5D0SaxQ4VZSjrWI6/ztDi3U3GS68cg/cwExnUKz9sp
         ewtuk04K4FFdKQVIJUExOkothGFTH7OiSJtlxDfyEP3ps4rWBgCh33H0hzht6GiGyxpm
         ESwiPQe94MJuL4O0Y4MR+/48lWi+URmc8+UShyXN/NCq4A2QnQd0dBsVHE/yCK4n+aAS
         Pdak+cbqQanLXWToHe08eXlP1VXWAUSRix863mWcnp0eWUI19Rmbt0ruj87mgiYqYRzc
         t6Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVMhmoQTTTaldqicWWCE9G1FXFBXRBTItJKxKagh4AwaoYL529sJws2mc/TTqt3RiV8IUy7+Nt2sty8SCF5@vger.kernel.org
X-Gm-Message-State: AOJu0YwaL/GzWJJhQRrPMWK/ua9XGOoUdDRcbkxt+YEUig1O4iF4LKln
	wXnIX5tJ1WJ19Ltisn7oxzJgrMjwZfyO4Ek8mB8Oz14davpgvmc2lsf0M8NpQO24n/AubqsOZLI
	2Y1KWdHIE4rZDewdcdEf56d/kAqewYGg=
X-Gm-Gg: ASbGncufcOewgInENMwAaFA8K5PgDvzgLKHK71CPER+m03Nf0GTQI5LF/+6oFPtponJ
	XXGE/kpcnx+OlSLITADghGG+A62/XQtnQPr0RvFcPZJ3XfzeNNn2sy3NHQfZ47AZRC3q4uslYSI
	aUIkqqp9PXH4myhFvrzyf7Hnk1maQOS3YBG7gcv7gnrx0aIvdTe62j8HIJY4xOFzAmzf8rhWVVI
	EnU4lL5l3u/N21/1War731WLk9vNafUXwS7jl6DWCnv2sS6PMO6jnpU6xziFjezDV68fmk7wWsl
	sIcRiYwJlz02lJEEauryNMd9fjd/pLZXsXYDtcaN0Zl6xGURBxffoZHofjEjTeh0FKhJbQ4VYeK
	bqn7cYwQaQGntiQ==
X-Google-Smtp-Source: AGHT+IHyjyBhvKxSJvpXE0N3bS4+qnIUQ/hrP8nt2xNCh1iG/p92wXmacntCXSyEtcLWpcePqvDURhRBURjbbMcC7kM=
X-Received: by 2002:a05:7300:7b01:b0:2a4:3593:2c08 with SMTP id
 5a478bee46e88-2a7249fec39mr7725470eec.1.1764165056986; Wed, 26 Nov 2025
 05:50:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202511210858.uwVivgvn-lkp@intel.com> <84b74435-5aad-4c15-aea5-db87b4a6bf11@kernel.org>
In-Reply-To: <84b74435-5aad-4c15-aea5-db87b4a6bf11@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 26 Nov 2025 14:50:44 +0100
X-Gm-Features: AWmQ_bktxfIw2Y2gRIytid6imUptHKKwkrT99X3ar_u-JsKJ1SBOQUCIAfvL4CA
Message-ID: <CANiq72mCd7FVO0Btsvct5Dy67TkBJd=QJgnPvLMn9d43Vy0YnA@mail.gmail.com>
Subject: Re: [linux-next:master 4806/10599] error[E0560]: struct
 `bindings::kernel_param_ops` has no field named `get`
To: Daniel Gomez <da.gomez@kernel.org>
Cc: kernel test robot <lkp@intel.com>, Andreas Hindborg <a.hindborg@kernel.org>, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, Benno Lossin <lossin@kernel.org>, 
	linux-modules@vger.kernel.org, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-um <linux-um@lists.infradead.org>, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 2:41=E2=80=AFPM Daniel Gomez <da.gomez@kernel.org> =
wrote:
>
> On 21/11/2025 01.24, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next=
.git master
> > head:   88cbd8ac379cf5ce68b7efcfd4d1484a6871ee0b
> > commit: 0b08fc292842a13aa496413b48c1efb83573b8c6 [4806/10599] rust: int=
roduce module_param module
> > config: um-randconfig-001-20251121 (https://download.01.org/0day-ci/arc=
hive/20251121/202511210858.uwVivgvn-lkp@intel.com/config)
> > compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project=
 9e9fe08b16ea2c4d9867fb4974edf2a3776d6ece)
> > rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20251121/202511210858.uwVivgvn-lkp@intel.com/reproduce)
>
> We can't reproduce this.
>
> If anyone cares, please let us know how to reproduce it.
>
> Tested on Debian testing x86_64 host.
>
> rustc --version
> rustc 1.91.1 (ed61e7d7e 2025-11-07
>
> /home/dagomez/0day/llvm-22.0.0-e19fa930ca838715028c00c234874d1db4f93154-2=
0250918-184558-x86_64/bin/clang-22 --version
> ClangBuiltLinux clang version 22.0.0git (https://github.com/llvm/llvm-pro=
ject.git e19fa930ca838715028c00c234874d1db4f93154)
> Target: x86_64-unknown-linux-gnu
> Thread model: posix
> InstalledDir: /home/dagomez/0day/llvm-22.0.0-e19fa930ca838715028c00c23487=
4d1db4f93154-20250918-184558-x86_64/bin
>
>   561  wget https://download.01.org/0day-ci/archive/20251121/202511210858=
.uwVivgvn-lkp@intel.com/config
>   563  git clone https://github.com/intel/lkp-tests.git ~/lkp-tests
>   565  mkdir -p build_dir && cp config build_dir/.config
>
>   571  COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang-22 ~/lkp-tests=
/kbuild/make.cross W=3D1 O=3Dbuild_dir ARCH=3Dum olddefconfig
>   572  COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang-22 ~/lkp-tests=
/kbuild/make.cross W=3D1 O=3Dbuild_dir ARCH=3Dum prepare
>   573  COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang-22 ~/lkp-tests=
/kbuild/make.cross W=3D1 O=3Dbuild_dir ARCH=3Dum -j$(nproc)
>
> I'm just getting these warnings:
>
> ...

Cc'ing UML so that they are in the loop.

Cheers,
Miguel
