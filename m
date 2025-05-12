Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC67925290E
	for <linux-modules@vger.kernel.org>; Mon, 12 May 2025 18:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747076238; cv=none; b=nlsfuq9c1sDLK1ZcoZHCrAY5UjoKMMeIIGwFuetwsg3VAg+p2CoqdAXwNs3f2e9J7NYw8u3DQaLPGcNoH/FdBvKzuxgsNw2c5GhNezbtgFKY9rbO7De8KhA5WeSV8PfulBZhM/2ym77IuQGicC3kZMpUyOAvPeYD+GLuGj4Xp3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747076238; c=relaxed/simple;
	bh=fbI3cjbsK0JUY5ujCpjGR4ienjUE2nrxQFRpNKrreTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8smnuVQfnOA4bHYxjoXah6IGDewJXOByYMvSKLesO8mV4yEWcmCahl5ux/yORge6Sj6agMcRKVRGI7VIM6T85rh9OmAA8zM6ID7MYsF2d4mXZZ36ty/SJG3WYUBERpBVOon1P+Qc6Gu1TZLx6AB91m2fX/2drHdatPW+vzNXa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gZOYMYZt; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gZOYMYZt"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5fbf007ea38so7926545a12.3
        for <linux-modules@vger.kernel.org>; Mon, 12 May 2025 11:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1747076233; x=1747681033; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cQkfO4hWqu1bvvz/7yqOd/ghHOaUeErpEqA6FiF+TmQ=;
        b=gZOYMYZtsjbVzqL8AegXuNmHz15qomaZTEjLoaMf01DQKvFFefpDB/1NAg/WnDeuUI
         ZWiHDVc2AnxRDzS3PisAMzn8npuxa448MLHrCccVPtyhH84leHPdqFTQ1MWqreTAg+Ei
         oTdA9nXGy4v1YGOZIdRaAvrmSjrpM068yoQkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747076233; x=1747681033;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQkfO4hWqu1bvvz/7yqOd/ghHOaUeErpEqA6FiF+TmQ=;
        b=wMu7YvD/jHHARTpU+eVcl7H05YwgyvIz4HcZI7N3Hvh664BVAGeVxJleppsOtFfRrm
         JIBgcRXH5Kk6VQTV5bLTPYDriLMc0s11ABKYtkHCJFol3eU2xrlAt8K49WJeVtR3ArFf
         9kypPwk2jeX8zyfrBf2hOT3CZmG+takrYEPYoqGMzZT2r/k9wqIgqDMWapltb8VLq1BM
         2J2gwb+awvvDyG/f2piKXx05UG7OmUlOw0fkAHUpR2VnVfaVUurxx5vrgYdWwEY6tnDV
         bf9Hb33Rjqf9vueGeVEpf6WPoMkML42EQ0G7SZmxjGc7sUt965//ttf5FOhgm9J/PL7s
         Lghw==
X-Forwarded-Encrypted: i=1; AJvYcCX8kwQwPBOk0std8ZOwg15laaCLnRLdcnEF2hZ1tV0aEEIe4dqddYcYh4fF8Se4QrltwnrySznmuXVuQfoP@vger.kernel.org
X-Gm-Message-State: AOJu0YyLwbqX4MlkAyFQH6KswCRSE106tAv99z/qQFGPryPGjl3urQkJ
	VGBgwJndxQmz6KZcxTRhwKX8x2UcnSNzhOAJU/OOlIAfI9qLLk0qE2wcA2pHx4IBwL+g7w9Ti1T
	eRDY=
X-Gm-Gg: ASbGncvPeV3f7uE2eTC+c8lqwuAKqxzRL9re9xD+O6hnNOjzi1zqbm80VExOlamZTKt
	i9vhJPLHHul7PmsMKtK5dZnvG2UfnhF5OZQ9BrnqQi6gtH/w/dWXoTSz4KfkKStpCMwMhwHDyS3
	tahCREXMrl7GN9wIyBtPz8vJ0sRcOnNTTzLZGjNRWFHVolyL1E2JB6In3TL3AZxoUTpNY19p37Q
	sYYfDyuk8uD9VWcHjxl+KeJD2XMYjhg7cdgLMsXkVzWtXqe4vXjE19TcZBLra1y/J0u9rK+P3vJ
	ucx+nESCR7d4GQdizeSdGhgOnVTCZhq6LsPGYNbFbfIBL0DteAMUvnpLaqmOKDaxOt5BbwPUS77
	kRLL5yEVUY2K9PkJBEPMIG57S8giD2mZNodxc
X-Google-Smtp-Source: AGHT+IEg7bdtAIpafWqRJxvpcuioWYXNTeacoG6N7lzdELkO4xR+MIJKLaTiuqINOC+daUz6Dk9QGA==
X-Received: by 2002:a17:907:9453:b0:aca:a3da:80b8 with SMTP id a640c23a62f3a-ad21917d128mr1656756366b.55.1747076233434;
        Mon, 12 May 2025 11:57:13 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad24085b44fsm397064966b.149.2025.05.12.11.57.09
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 11:57:10 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad24677aaf6so248224466b.2
        for <linux-modules@vger.kernel.org>; Mon, 12 May 2025 11:57:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWPMvMaTZ66oUAz/DxF8Xtjzliz9lWMij9dM+Sw4HKtY639Rbp0bMfpZazNyAMmbsq8/++xmcoA9tfQC7FC@vger.kernel.org
X-Received: by 2002:a17:907:a0ca:b0:acf:b8:f5d2 with SMTP id
 a640c23a62f3a-ad219007735mr1331166866b.36.1747076229361; Mon, 12 May 2025
 11:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0e82be0f-a305-4aba-b9ab-79596f595277@suse.com>
 <CAHk-=wjNj0vHh9v6-LTrbgtq=o6OS+RN3u3m03nV3n9V+urGtg@mail.gmail.com> <f40c3d5c-edf8-4d3d-a50a-506c5b6d7bc0@yandex.ru>
In-Reply-To: <f40c3d5c-edf8-4d3d-a50a-506c5b6d7bc0@yandex.ru>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 12 May 2025 11:56:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=whBF_ikhpCa_uW6Ahh-2TWh=5g8WydY6P4_Fy3sT9EmMA@mail.gmail.com>
X-Gm-Features: AX0GCFuKupDElWgaZY92g6wcpisiuYtRjjFMNH5ooBdLaCB7fzmVdT_PTNET0h0
Message-ID: <CAHk-=whBF_ikhpCa_uW6Ahh-2TWh=5g8WydY6P4_Fy3sT9EmMA@mail.gmail.com>
Subject: Re: [GIT PULL] Modules fixes for v6.15-rc6
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 May 2025 at 11:14, Dmitry Antipov <dmantipov@yandex.ru> wrote:
>
> Technically speaking you're right, and I will take notice on that for
> further commits. OTOH replying with "please adjust commit message and
> send v2" could be the way faster.

I suspect it ends up depending on the people.

Personally, I tend to dislike being on the receiving end of the
back-and-forth of "fix this nit before I'll apply things", so I
generally try to avoid doing that to others.

Yes, I will do it for things that I think matter, where I really don't
want to have some bad thing show up to then be fixed later.

But I feel we sometimes have *too* much of that code review attitude
going on, where you end up with patch series that go on for multiple
versions because people keep reacting to various small details.

So most of the time, I'd rather just get the code fixed - get it over
with and leave the issue behind.

I'll point out something I think was wrong, but not fatal to the
codebase, and hopefully just make people aware and avoid future
occurrences.

IOW, I didn't expect my comment to result in any particular action
this time, just a "please think more about the explanations".

              Linus
