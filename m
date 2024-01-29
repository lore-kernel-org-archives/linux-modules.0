Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C9B3F9C1
	for <linux-modules@vger.kernel.org>; Mon, 29 Jan 2024 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706549038; cv=none; b=UP+6lZB3ZtGkuZf8qlqQkWkZr5wsldfMSJqs3APIT5CPZbZkzzjsQiwvPKLxLHaV7CMY0l41YruxIBGM5ue8oMWHkhW7CTfRUbt6OId/dyF951zR30StOOrs/ZobnTx9s57wsztKamcmGgiQ/ARmveVSsW2YIlGUGg3rW5YfcLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706549038; c=relaxed/simple;
	bh=4opMWeikH+W2DsgJwssKV2RPeO0UGmYBd/1N89Wxs8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DndL5nhz54nYhyeujAW8Ep6zdCeoM5CfJ4h7mbZeNC18IKoaLk9asCHQc9mGPkRcKxLLAsidOiVeVzLjcURdggQuvsFp9d53aVUiJ6nHUI22e5OJvC8QfXgWKivEr5rqnVHZu9lBwSGDyxYI4WvUyFQw2tWHlFqJkp77N8KQnpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7Klfe5x; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7Klfe5x"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-603e370790cso8088827b3.3
        for <linux-modules@vger.kernel.org>; Mon, 29 Jan 2024 09:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706549036; x=1707153836; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4opMWeikH+W2DsgJwssKV2RPeO0UGmYBd/1N89Wxs8M=;
        b=k7Klfe5x3NLz9jz5pE3IM3T8lUwde7EQ52A3OkWYn4MRcEUK5M8YwWOLGyibgj6WIb
         e/2aO+aAwRNLY3I1BmYzU5Cw0r1dJFnC3Fq+3tMscRZAWUwXKW3lvF7jP0CvDF0M9wzO
         kwpQWmyTc7NIHCuNC9V9d1Deceop4VJq6p2/fb28kpf8LehdejMekxjJxGcF7cJVLQTM
         G3PHyIywf0L7eSiDDz/SWDhRDMzEHVGsmhvhRejINCd+uDKzOXiYcBrTGZwPDvCpxaxO
         9D6h3aXyFfUWt9JrAZMiKvRmTVonPpu1f8gNhXZbK2m9x9xdWPZBqa49IdAWqxMnIM+L
         WwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706549036; x=1707153836;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4opMWeikH+W2DsgJwssKV2RPeO0UGmYBd/1N89Wxs8M=;
        b=FlBAXeEhWv513lqzZAQ+rJ9reZJgGXU6Wz9ukF2f7Ie3v/PuE88xR0gy85oBOMwIva
         wqJP7QH097pxmjGzQF5xuBcEIPokC3arOshQdUSSux6mSvwGgAoGA53n9O42u4lxsPI6
         NtyOLYo1BTWyRSpgCt8Jddtf7wI3FrhYI9zDMVymG42RQbUDxy5KatiU0xIAJl0MR0XI
         azh27VDVhpRqU08VLUL1/n8Lkr/1s1X+iayShRiudFqwQvjaB2kOFo7PBoJclpKsv2ea
         dNXTc9ouaDlsLbKjmf/WI+kzAZ4mPFesDkkJVEbHvV3MGOSQBseKUMIxPH0Y+WLl+Znc
         A4uQ==
X-Gm-Message-State: AOJu0Yxc6qiLv0hSH1USIdRagZtkpUCJaLHUSq0rExRRiS/WkeEQgc4+
	r2LEhyql6AXqBsW2sDRLmB05ZWUN+oP94SJR85HC4l88ExGlvCAZV096KHxzQnWdgkZSAhWN6as
	lARg5iCA3wCnpJWRRliTO+Kl3JzQ=
X-Google-Smtp-Source: AGHT+IEIGxfU4xgZ/NPoCADhtpIkPdif7mI47xqnwX6l/Ti30iAzpxHrJd3tsHacVna3nC9HLrsXncAlc+X8MrZI4qg=
X-Received: by 2002:a81:4815:0:b0:5f6:fdb0:ae76 with SMTP id
 v21-20020a814815000000b005f6fdb0ae76mr5359996ywa.37.1706549036028; Mon, 29
 Jan 2024 09:23:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126-master-v1-0-6257d039a30a@gmail.com> <20240126-master-v1-2-6257d039a30a@gmail.com>
 <tdvymg3uuvkns4uqvivvvkj7sf6pqr45rpbyqmngaf3jmvqije@fsuvyu3kai54>
In-Reply-To: <tdvymg3uuvkns4uqvivvvkj7sf6pqr45rpbyqmngaf3jmvqije@fsuvyu3kai54>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Mon, 29 Jan 2024 17:23:44 +0000
Message-ID: <CACvgo52Eb1MV328RPUPLDq8cPO+7NvHn70q3SQdiTr_apnE5dQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] make: install/uninstall tools symlinks to kmod
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-modules@vger.kernel.org, Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 16:40, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>
> On Fri, Jan 26, 2024 at 02:43:51PM +0000, Emil Velikov via B4 Relay wrote:
> >From: Emil Velikov <emil.velikov@collabora.com>
> >
> >Currently we create symlinks like modprobe (pointing to kmod), during
> >the normal `make` build. Although those were never installed.
> >
> >Add a few lines in the install-exec-hook, to ensure they're present at
> >`make install` time. Thus one can actually use those without additional
> >changes. As an added bonus, distributions can drop the similar hunk from
> >their packaging.
>
> It was a long time ago and my memory may be fading, but afair the fact
> that distros were doing it was what prevented us from adding the
> symlinks ourselves.... and then we never re-visited this.
>
> I'll dig some history before applying to make sure I'm not forgetting
> something.
>
Ack, makes sense. Fwiw I've already opened a MR with the Arch team
highlighting these changes.

Sadly I don't have contact for other maintainers.

> >
> >Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
> >---
> >Out of curiosity: are there any plans about releasing v32? I'm
> >interested in the recent /usr/lib/modules (module_directory) patches.
>
>
> yes, I should be releasing that soon, probably this week or the next.
>

Thanks much appreciated.
Emil
