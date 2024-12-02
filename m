Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21F61DE4FB
	for <linux-modules@vger.kernel.org>; Mon,  2 Dec 2024 19:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733168061; cv=none; b=UgYJwbkytGBUUpfYDJXGJT1KEuC5AW2hrvsbwLquxPmACFZi3XFaxGTd1EQ6eeXrc+BKgZWx6EXe06yIwCq9ZQYZUq0wgU7/oZOYxjBaTkOZj1V7/GZNKS8cP7oQlqSDvKdbQpVQRzhgD2bL+1DcB3ASDpqOlNEjd4uHyKkgFiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733168061; c=relaxed/simple;
	bh=R1wjqLCnK/jl668F/7xiZbuQwwYunoRzMSm3GVh/kRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1vA2wvKG2mov0vbfuTbcl17LYqhPaTRCI8ZXOwzi0j6XFKSAmpShoC8PXIeCe1Ze98s7o1xy2lUxP23GOmsyjtksVM8HTwJwT1Upj1/cfiIgffFBDF76zRiT8QjRyg2fq0jF9ZMPM3P2Hd93IgOiLLL3Ag3oB4v6AuL2sAZua0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hGmpf/J6; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hGmpf/J6"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53df67d6659so7127124e87.3
        for <linux-modules@vger.kernel.org>; Mon, 02 Dec 2024 11:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733168058; x=1733772858; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NKeXocoBU43F0p08iiIssomLE42KNiU+OuyoZjKEnbw=;
        b=hGmpf/J65bEK1UIOvPJrNg2ecoH4BBIkrSicmaeSbG1D3b86paPrEbyQd16UPLGRDb
         Db8M4bCkQiqqcNDmLJWuYIXnsRNtKgFeRFlXkBbCv8gicYgU62NLxg5IcIl6r2KOdSup
         e6hiT/m8zCT1Tqhd+bHIk63aV8QWpBEisRnjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733168058; x=1733772858;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NKeXocoBU43F0p08iiIssomLE42KNiU+OuyoZjKEnbw=;
        b=q3J51wtkMzhM8gNz3GCoT+q/woCRJdik9A3JnaJ+E9/sbxSBwKiWxIYk+zG7l2F3Js
         bD3yP2btW5la9gqUxlx8NNy9e06fCrB4Nlcv9y+bu6YKThy44DyrMk3T6tKkgayZLhzF
         yidurdiFQSuyDNpY9s2L6v7soZZOR0TneJTQslhykmEiOKFIDyzNfgWjdpIB91O9UWm1
         ej/nRT8bpdEyy3kfH1yawRm4fwMvGF5Gp66g8DhFLzGrkrUSZp1V8FdkGuGL3JmCWbxg
         DHamtjs1qh7j6PJYUHGdJKApeYin9u6hfZ3u9DioRt5n1FOXxmmCap5RrJ8/ePlYyX/S
         45nA==
X-Forwarded-Encrypted: i=1; AJvYcCUsZ9zu6OZIKpGnhhQXDDLCv5HDW03aB2nJJTDrnZug5lVvnFME2BYWGDXPAQrlgoAP9/uRW0vz//42eZZf@vger.kernel.org
X-Gm-Message-State: AOJu0YzgTiSYU492YwJIZS6SQC897qvj58Spi3W3Josby1VNB0eA3mXl
	CnTIQK6P9XWF3Ai/Yp0W5AxB/sOWggNIF+1kD7XPEcpYD9WAeg72KQ/Af9ynv8LiFiip14+vVZl
	YUv5NEw==
X-Gm-Gg: ASbGncuNFX277on45Eb5Uy/GPr5Ph+glz6ldCx3fsZucuJpHmJvWIjyhXagSuBvd3mS
	hU4X/5dp9pxziwR27Wc86pqxp3BL8lUe4yAOLKEdDdRWWrm1wSSdXBaF4g5Qpxc+ZWllIrsfPks
	oDBgFGMp0k1zNWekRtO7QAD0OHRXU0JSkJVaqspTNKTrG08fMEGJ2ExYcU79gM8dekjTBfwvnLJ
	sGGzp53cGcy2S6F6YQm1oanzV5QoxtK/Im0TC2/TzGfSILOGE3hqK9/UoHkbO/TZj1Oik3up58q
	cm7pFs78iyRzj4rujwmyMRdif0jl
X-Google-Smtp-Source: AGHT+IHyQsEY/Rr9fEeJm/jEv/wYQJCOcmZRQ+NG3Pso7TpW0wOfSs2lyiWJUrWuR5K9DUIemmW63A==
X-Received: by 2002:a19:9147:0:b0:53d:f0ca:41f2 with SMTP id 2adb3069b0e04-53df0ca4242mr15898183e87.41.1733168057650;
        Mon, 02 Dec 2024 11:34:17 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6496a10sm1546028e87.203.2024.12.02.11.34.15
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 11:34:16 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ffc76368c6so69756961fa.0
        for <linux-modules@vger.kernel.org>; Mon, 02 Dec 2024 11:34:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUFhtAxCUpSeeXKZlS0UDYjRgur/IIgYnjPzfvzipwcNdWDbHdvbCCnpC+f9vgzWMeoWBmmJOIf+obmDOZj@vger.kernel.org
X-Received: by 2002:a05:651c:508:b0:2ff:cb81:c016 with SMTP id
 38308e7fff4ca-2ffd6028d77mr201405821fa.19.1733168054547; Mon, 02 Dec 2024
 11:34:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202145946.108093528@infradead.org> <20241202150810.048548103@infradead.org>
 <20241202151533.GF8562@noisy.programming.kicks-ass.net>
In-Reply-To: <20241202151533.GF8562@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Dec 2024 11:33:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh7KugYO+R-1DMmkLz4fD_-A9BMyrWTVsH_K0a86Ojn4A@mail.gmail.com>
Message-ID: <CAHk-=wh7KugYO+R-1DMmkLz4fD_-A9BMyrWTVsH_K0a86Ojn4A@mail.gmail.com>
Subject: Re: [PATCH -v2 1/7] module: Convert symbol namespace to string literal
To: Peter Zijlstra <peterz@infradead.org>
Cc: mcgrof@kernel.org, x86@kernel.org, hpa@zytor.com, petr.pavlu@suse.com, 
	samitolvanen@google.com, da.gomez@samsung.com, masahiroy@kernel.org, 
	nathan@kernel.org, nicolas@fjasle.eu, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	hch@infradead.org, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Dec 2024 at 07:15, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Perhaps we can ask Linus to run this now, before -next fills up again ?

Sure. I did an unasked-for scripted 'remove_new' removal right after
rc1 for the same reason.

If we have these kinds of big scripted things, right after the merge
window tends to be the best time to do them. The conflict potential of
leaving it hanging in linux-next can be somewhat annoying. They may be
fairly unlikely, and easy to resolve individually, but it's one of
those "one is trivial to deal with, but even just a handful is
annoying".

So I'll run your script and take your commit message, and we'll have
this part over and done with.

Thanks,
            Linus
