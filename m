Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8367738B148
	for <linux-modules@vger.kernel.org>; Wed, 17 Jun 2026 19:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781724630; cv=pass; b=uLctEq4OJn1xPg33Ws0pouWL1H9XUurHMX4oFMqDwx/9HPSOFIiV/jz0tfMeAKwBYhGw8ROCyJpS/9gaB+HQ2Ndb3LYyuv/7rG/gdt6yllY/0+4kNY/1Dlm41PbvU9AvM/ZhTkadlmML1hTmbY8vAzUl1yvQymkCGO5Cjcz6zpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781724630; c=relaxed/simple;
	bh=yDzv5KtKe+Kk986ajfvNRzKO+GxC8FicWRT93AeKzoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lYoJeniIZMo/HtKwaBFG0Odr7WQceqY3sFlTtbdDI0de5QXoktBQY47hRa1Jju3WUNRRs/QEIROJwqQoyryYHca7REKOwbBBBDmlCd89ymkhgiYW2q42q4jsNO74fcUKeRvi90i7ncMY7KAdzbylWGoIlwPfmkTyB65jNUtWxNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CJmWwU/M; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CJmWwU/M"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5175d339e8bso56001cf.0
        for <linux-modules@vger.kernel.org>; Wed, 17 Jun 2026 12:30:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781724628; cv=none;
        d=google.com; s=arc-20260327;
        b=p58rYXFuXHyOxTolkJpU7kbgLSzzcnVJUBD8Y4GWySUH0fG4uUuKBT7rbDm6kGWf6w
         x/7qvtTjyCdU1SdNyXw+jMHEWMWKlPHVmKjF4y5sWRF5bHYFZGqL+hZ/UYbZiFYkw0gB
         d/eOnaSQWbWTVA/vpvprxnvPW2+dg8cG5o11kB25VxroeGA3oeplEVvMX5+cHMdKHCgx
         s5X/v+f7OX0CaZsWWz0XbQ5X8FAJQSjNWGJCBIC6em6nBhBDWkTCRV2DEfGIdIGAeVnc
         p4CKWKp+3xk/YkZ9Yxis9GCJ/56/LvWVBx1MG+5yO129Sp5zuAZvsZdaJSBGMhGDUBXi
         ghDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GiycCcQF13rQSyejTT0C3ZPPCWaK6Y9TJsOw6qd0fOk=;
        fh=BqZnufcUj5JK511WfmpocjM1IgsyPNmTffYTPQJkTDA=;
        b=Disac6irL137kT6jA1LjTXujHlTO0zVuVarnY/nVR4mSLGSTopq1Q6xRF0NPOBQAqn
         oaXWckuY0zgDFhte8uzOs2CKPN2jdtjSqWhdHm94yfnas+AbIEay+A1Uo4tuiUqEIAgr
         TUswOXrF038aw0jx+yVMvfEuE2XXl8w1uoCxZe4/j+2AOYNGXCLEKXZORETuGDLgDCx0
         8N1bkkuOh+MGUFmtDC5RglezFlCF4DIgMQJEu7/xp70aL6jfiz3rM0qiBiCVhcxscwsd
         OpSEiQOmnkKIxCLXz/lPXsB1dnpg+yNGNk+dt229Qq1RCRJIW887hSIA7k2amsVBtYgm
         qqbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781724628; x=1782329428; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GiycCcQF13rQSyejTT0C3ZPPCWaK6Y9TJsOw6qd0fOk=;
        b=CJmWwU/M2SEn0LkBl22SsY15JBmqX4FqS1Uq3ir6Pq6brKU1qTDHF8Vc2KkiA33sr0
         P3oh6fA+Ye+k0TLKAFr7qYXO4QHzoiYDbGXRiFGnprpZJM4iGMaBkz0ykZd9pM3aE8S5
         G89iDghcwfRI+plbXRkABU9VBeJ5E8NjPzmMOOoUooOMGqylkchhU6mn+YexuY3UT4aC
         +Jc8THkoJzzuTXE5gMCtC2zB6Zl1gSHjctzVUEH13ysJ/Ew0CKKumnqptEfQdioGXtoR
         rDBhECgOOCFqTOVajai2Hotnh1RQG4trv/fqgDNd4w49309GVo1QXpHFm0IJKOV6jMpR
         qcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781724628; x=1782329428;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GiycCcQF13rQSyejTT0C3ZPPCWaK6Y9TJsOw6qd0fOk=;
        b=U/jTQpwUqGODWypcLilQ7SG3DPVtkTSk8+W9hqGHO09JVba6hjJ+ry9be9qaK7JlcY
         aM+avKxuWqaPkuMmC+idAzdSPAygf1b9OqixdVUDzsbgIb26nW45JIJolzKLan+v7TE7
         vxrvySF3c1uUy/Fvr0DadZtM8dZz2CNAdUN9OzFjWvvWaclaO01srl8lBTxxkx5aqzxr
         5nvnXwsyhPfnfrhYuxb3aCRAeKC2/oBEYI7EXldsAylK7zEpJdw3VHX42S8XNxgi0ju8
         QTyd3nhEhBFA3FGZbhZdbW1vxcWNXfG5nqIvEzZUF6t7yie6j33T8NizUCnD2ODKDaAA
         uVOw==
X-Forwarded-Encrypted: i=1; AFNElJ/6NeeV2l+ZJ4y3zrzcKyeqVD/gp4HiG76zeisX7A4oBgfx3lzahHlNRvxjOQ/mTMDJzyAGlVZn4t8EYjmJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyteG+ER2CEPLfBHBrEGsMN3rqqrAPbicmf3vLK0lhQqKgGASOc
	LkNe82xjrS3q8R6KyrysoUIGQL+I4Vjti+aC/M1qr/B+u/uGZlp+i/Bks74GclB8o6ejfGo5s5Q
	ZecU5JSVJnD7JpeJbHO4L/GwD+hdyqQ3Yxu4dvK9U
X-Gm-Gg: Acq92OFzmD8eDr2y8fr7gCQj6cL6S+enmpYaJ4mYQnrhHnfFAUJTs14ESBEQuMGr1dL
	EigzQZkjLM3154Q4NnB70PF93tDdxy8Xhp5y2TEWiXFw1RD0ase33/BUAG9nQQ5L0l4QF0PY6fm
	kyLmXjiHS/iYdObIL+46erBAbWQizF4VUfMT1hp7RaMp7/xGbilX0LS+vo9UO/NHWkjqclBnHOP
	yL/Dz9fEMKL32Tmg8JRrIDEssz8AbLTmkS1UfTfrjgs7vyDuHos20AYvYtlQtQgVOIvlht42dUF
	mAOF
X-Received: by 2002:ac8:5ac3:0:b0:516:4f62:85ef with SMTP id
 d75a77b69052e-519c6736dfbmr1496551cf.20.1781724627525; Wed, 17 Jun 2026
 12:30:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612133920.1919352-1-petr.pavlu@suse.com>
In-Reply-To: <20260612133920.1919352-1-petr.pavlu@suse.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 17 Jun 2026 12:29:51 -0700
X-Gm-Features: AVVi8CegfmPVO6dnf2iIhQntOfDUU-3siq95A_gDVQ4lRsXorNPKB69qunolNws
Message-ID: <CABCJKueO3NkVrsR9H6JxFpEf=UsGZ2PCPSrs6hXJh+cdBjikVg@mail.gmail.com>
Subject: Re: [PATCH] module: Remove unused DISCARD_EH_FRAME definition from module.lds.S
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>, Ard Biesheuvel <ardb@kernel.org>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 6:40=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> The linker script scripts/module.lds.S contains an unused DISCARD_EH_FRAM=
E
> definition introduced by commit 68c76ad4a957 ("arm64: unwind: add
> asynchronous unwind tables to kernel and modules").
>
> As shown in an earlier version of that patch [1], DISCARD_EH_FRAME was
> meant to be used by SANITIZER_DISCARDS in the same file, as follows:
>
> -# define SANITIZER_DISCARDS    *(.eh_frame)
> +# define SANITIZER_DISCARDS    DISCARD_EH_FRAME
>
> However, in the meantime, SANITIZER_DISCARDS was removed entirely from
> module.lds.S by commit 89245600941e ("cfi: Switch to -fsanitize=3Dkcfi").
> Eventually, the mentioned commit 68c76ad4a957 only added the new
> DISCARD_EH_FRAME definition to this file without actually using it.
>
> The file include/asm-generic/vmlinux.lds.h contains a similar
> DISCARD_EH_FRAME definition for vmlinux to discard .eh_frame sections tha=
t
> may be present when CONFIG_GCOV_KERNEL, CONFIG_KASAN_GENERIC or
> CONFIG_KCSAN is enabled. Testing these options on arm64 with LLVM 19.1 di=
d
> not show any unexpected .eh_frame sections in modules.
>
> Remove the unused DISCARD_EH_FRAME definition from scripts/module.lds.S.
>
> Link: https://lore.kernel.org/linux-arm-kernel/20220701152724.3343599-2-a=
rdb@kernel.org/ [1]
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
