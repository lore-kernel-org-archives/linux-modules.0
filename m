Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD99202F8F
	for <linux-modules@vger.kernel.org>; Wed, 27 Nov 2024 21:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732742579; cv=none; b=m4LtrsQ8x3YwyJervrdbDFIHUFsup17LxEz3tJZ5eYQYX1b+IIweV269cBc6mkcTyQ4M3PIxkUtN1Fo1csQScjLbkN2tM5UOamVGEbx3q9JyZ1AoudPPqWz7ddZ8xhQZWUoB0KPbwevNE57f4Vi6UIcTNuZTrAwTHaMEYqTDoZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732742579; c=relaxed/simple;
	bh=mDS1XojcKgyKV+qhf+mZoci6ei6W3HBx9/RajVFqU1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gorrdI5c6Y1QYsTScYZKWtRvNMMB4FH1dt6thhmDXiolzjY63AonJjFIjwFiHysq1iD8qkbm4IUe4yAFJU41b8tTnv8O+ItWVrbYCFILztmR1ikxANMNE5O8aRf5+jM5aWzQTecS6sVaZ4IOWJCmEDD023ro5dqvXwwAq6QZ+8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=O7IY2q+3; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O7IY2q+3"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53de79c2be4so135674e87.2
        for <linux-modules@vger.kernel.org>; Wed, 27 Nov 2024 13:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732742575; x=1733347375; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Au3QzJwj/0l4623aVKpu/uhJ436TUkwvUw3oPsNH4kU=;
        b=O7IY2q+3UaWTPTNGuDEKL6xLvh5Jq2k6fOTfjAyyb3iGpR5XXfNivyT/yhKNCdfPor
         1mqWJePASV99tNACGwr1rb7S0I1+Py/Sq6Vcase0DXqld8dPoBoxssQxkkO2TA1B1YY0
         SKV3S7fPIA2ukL4gCDXBPf1qDoXOeBeX1v/bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732742575; x=1733347375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Au3QzJwj/0l4623aVKpu/uhJ436TUkwvUw3oPsNH4kU=;
        b=ufDEnAGBOQ9buJJYqH1+MUfh/Y7ZHZI9pjaTq+uoilnNO9cjfx8Gj3hrOHniDEJOpH
         lDyu0q94Dysa1TEcOJr0RbfHCzyccg8ewdi0kfjf4ZtcW+Blm0ne63Hq5R53JcQA1Nbf
         zHhZ/S2KrZ1O960HmD8KyPSVLm7drLcz1SeNwOxGQin0Jjuflip7uyEYQ0SMPwFVotIc
         /7wxQoEjv4qXYXZ4w9mbEVcVYu46x+USRwYYMQAPWvYJsAQlSez8fh4R/OnXVdCpVV4z
         glQ8jy3ceVvvndi7AsISkj1kSM0PFlZBXEP6q3f1QTjIvTymSxGUeojGpBp5aB55egxL
         N5cw==
X-Forwarded-Encrypted: i=1; AJvYcCVxk6amE6pIBPOvwsGh/zUvgOo6Eu/mKFvRnWzM75IEo/wzi90B4u3uCE4jr6KkPTu/esKXqiSXb1kjPyY+@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+1rNT31JBi/hcZmw3LVcN7mP90xY2ADVlVhJHdzws8nl8571P
	nhgveGgRNR0d/728XMbH2VaeZwdlNSDLKZ3RlyrSt2L4h2XBf63CjDbonZnTD56BHP/0XpT552c
	bNSU=
X-Gm-Gg: ASbGncu59lP03eE7mqmXQKQr/vDbVZiq1L3sabGkZykFFIquSTHtBQk/sBqoT9ByyaF
	uDwaETby8BeWkrRE7U6ISqZvywqvF6CEeg3e9nmhbCoelw7kZOEvmQhHT+2TJM1pklQz5Z3jLG7
	V9U56KJ07bmPcPH4GVSFDAME5AtJNpASuvarVA3Xy24Hi9JWbe8k30XdZqZXObR6DrKX5E2JcNn
	lGwd+qouxxUhWY+qYkRqQTgTzz7CRIF2ZgyyONCMjF3FgfE4RMSO2ap7KlPVzERiZoUBO5l8kML
	OUVJ2boheZj2cKkKNkJgoUrX
X-Google-Smtp-Source: AGHT+IE9CAj1kdQkZAug35vHU+KkmV9ZafI5RNgILujmgjicg82D7O+PR794EMNlP5X7avkhkWDsiA==
X-Received: by 2002:ac2:531c:0:b0:53d:f1cb:624a with SMTP id 2adb3069b0e04-53df1cb62b0mr1794866e87.26.1732742575122;
        Wed, 27 Nov 2024 13:22:55 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa54c4eeb1fsm452521266b.32.2024.11.27.13.22.54
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 13:22:54 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa530a94c0eso14573466b.2
        for <linux-modules@vger.kernel.org>; Wed, 27 Nov 2024 13:22:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWgpTuIayJogu8FKHDBzp+NpC/Bt5+AY86e9VkAvY/JdqspK2sSYg8kHAH97Q/2VmLam66KqTl5dNb7s0cV@vger.kernel.org
X-Received: by 2002:a17:906:5a5f:b0:a9e:b471:8008 with SMTP id
 a640c23a62f3a-aa580f6add9mr299720866b.34.1732742574156; Wed, 27 Nov 2024
 13:22:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z0ZxiLw9hauUynTS@bombadil.infradead.org>
In-Reply-To: <Z0ZxiLw9hauUynTS@bombadil.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 27 Nov 2024 13:22:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjCkJsdLageTx6C4n--aYFoO6gSRe0Rwcbk1jQdOdiPfg@mail.gmail.com>
Message-ID: <CAHk-=wjCkJsdLageTx6C4n--aYFoO6gSRe0Rwcbk1jQdOdiPfg@mail.gmail.com>
Subject: Re: [GIT PULL] Modules changes for v6.13-rc1
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: samitolvanen@google.com, petr.pavlu@suse.com, da.gomez@samsung.com, 
	linux-modules@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, masahiroy@kernel.org, mmaurer@google.com, 
	arnd@arndb.de, deller@gmx.de, song@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Nov 2024 at 17:10, Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> Highlights for this merge window:

Lowlights:

>   * Adds a new modules selftests: kallsyms which helps us tests find_symbol()
>     and the limits of kallsyms on Linux today.

This is completely broken.

Try doing "make allmodconfig" and then do "make" twice in a row.

It re-generates the tests, so you see this:

  GEN     lib/tests/module/test_kallsyms_a.c
  GEN     lib/tests/module/test_kallsyms_b.c
  GEN     lib/tests/module/test_kallsyms_c.c
  GEN     lib/tests/module/test_kallsyms_d.c
  CC [M]  lib/tests/module/test_kallsyms_a.o
  CC [M]  lib/tests/module/test_kallsyms_b.o
  CC [M]  lib/tests/module/test_kallsyms_c.o
  CC [M]  lib/tests/module/test_kallsyms_d.o
  LD [M]  lib/tests/module/test_kallsyms_a.ko
  LD [M]  lib/tests/module/test_kallsyms_b.ko
  LD [M]  lib/tests/module/test_kallsyms_c.ko
  LD [M]  lib/tests/module/test_kallsyms_d.ko

both times, and this has made the empty build slow down by about a
factor of two.

Which is a big deal, because the "empty build" is actually fairly
important for me. It's the baseline build test performance, and with
small pulls it actually dominates.

So this isn't ok. Please fix asap, because otherwise I will just
revert it - it really does affect my workflow that much.

                  Linus
