Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1AC4248C5
	for <linux-modules@vger.kernel.org>; Wed, 12 Aug 2026 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786547868; cv=none; b=hpPnO9PHwOakyrWNk/DJvooAQijCISxSoBDUIZZZOSy+AFpziddoRY183RMuFpIgpNA193hNyP9HAL+a7oSRBWGuFL0n6qQLT44Sr3ocl90rFUs0ykG60PppINewWVEKVoSgyR3aNxBWLngfXNRkOj6wQ0yr+Wbc0fZuOsyTgBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786547868; c=relaxed/simple;
	bh=jwDMgUPHkbOCJu9ptvK1dhBFbozu9J2QR4s5hOwE6uQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z17IgDizMh5QlsK9NLv61E6qWS4EfHVLRsF7PqFG8kv6QYglCFnPO1G//f6cW87HV0Hy/32wUhWGTbxDFleJNB5n3BWJ1SieAkU88B3ypfw76LtTPKQyOvGXn6OSYNFCK6AB7MnlyJz6L6xBO+hnh6xIEamnh5CUG47lVR6CWFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVrXFDs3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVrXFDs3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D92F1F00A3F
	for <linux-modules@vger.kernel.org>; Wed, 12 Aug 2026 15:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786547866;
	bh=ik2fuz9TuLVHsuaLwF0Z/EF0E1lbisTBGZFFl5LwWfg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IVrXFDs32DQqUoXDf1/vSKCOHOzs17duCXdbSVlqkNj7ZlTKnh+Tt35+diZGfHMoY
	 o17p/OBO501lnBfXq4HVXh0pQre68o/+22fq4Ew19g4eoiSBvFNnB5mXKwng4fsaqq
	 aqlzFL8ONbVGTTciy/81hzET3/wLZBsjQT8CR+HTd2lrwPW1k12EQcWPrjJ/aPNrqS
	 yqBUlQOKVroKaJO/Ex+YvD8Pm2XgZzioS/f20+p6/nvflWbumYCA7/tCAXPoA2NcpE
	 pxj9Re7Bag694sFGZDLpnH0J+8lEhlbZ4hkglOJolitMBKucDrQI/xEN5EmuCAOY4O
	 vgZKv/+0oMRBA==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a157f90752so1777944a12.3
        for <linux-modules@vger.kernel.org>; Wed, 12 Aug 2026 08:17:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpClt0TKU57LEI5S4aCzrhnPAmIssRF1PkOV+Ymj8TUe+b2t49z8q+a1IFVMYrQEVWpPfdBn0SFVgF6P6i9@vger.kernel.org
X-Gm-Message-State: AOJu0YxqW/WAzUoy4djg2JTQg4qtFdXWNUDTYJ6qgVKxbamBne/LxeF/
	kUtFDYKCDwfBq5E459EsX3FpLgjBDJYdqrBuxz4+9IqrUD4g3wFodZfs9/Zfu5dCtwfUdShleWk
	AQmmaJmlZ1/Ve9dGJkUcFtqsrIJ3yBEo=
X-Received: by 2002:a05:6402:ea0:b0:6a1:4458:7f2d with SMTP id
 4fb4d7f45d1cf-6a375eadd01mr2786148a12.5.1786547865002; Wed, 12 Aug 2026
 08:17:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812032807.15034-1-yangtiezhu@loongson.cn>
In-Reply-To: <20260812032807.15034-1-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 12 Aug 2026 23:17:35 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5w8VVW_L6cRes-syjEvhbWmevSKWrZWPFapRkuemmjaw@mail.gmail.com>
X-Gm-Features: AUfX_my7amXpUbUaFyOB9T3ZWwS1EoRkTROxoDguMKCdpASA4Taw_zoETGoew_I
Message-ID: <CAAhV-H5w8VVW_L6cRes-syjEvhbWmevSKWrZWPFapRkuemmjaw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Filter out local and mapping symbols during module load
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

But I still don't think renaming is_core_symbol() to is_kept_symbol()
is necessary.

Huacai

On Wed, Aug 12, 2026 at 11:28=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.c=
n> wrote:
>
> This series prevents compiler generated local and mapping symbols
> from leaking into /proc/kallsyms for loaded modules. This ensures
> tracing tools like bpftrace can resolve accurate kernel stacks on
> architectures like LoongArch.
>
> Based on the v2 discussion, the changes are now refactored into a
> clean three-patch series to eliminate code duplication and clarify
> naming.
>
> Tiezhu Yang (3):
>   module/kallsyms: Rename is_mapping_symbol() to
>     is_local_mapping_symbol()
>   module/kallsyms: Refactor current symbol filtering into
>     is_kept_symbol()
>   module/kallsyms: Filter out local and mapping symbols during module
>     load
>
>  include/linux/module_symbol.h |  4 +--
>  kernel/module/kallsyms.c      | 59 ++++++++++++++++++-----------------
>  scripts/faddr2line            |  2 +-
>  scripts/mod/modpost.h         |  2 +-
>  4 files changed, 35 insertions(+), 32 deletions(-)
>
> --
> 2.42.0
>
>
