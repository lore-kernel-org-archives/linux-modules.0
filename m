Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6D2212B05
	for <linux-modules@vger.kernel.org>; Fri,  9 May 2025 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746807586; cv=none; b=EengRfccdNfNd3FHcRyemsCgZYBOlgVfzsKqRs27AiU3GOV7zqdYtKZz88bzg3PS8Jvkr0OR4qPHlrWeMoYQSavew+PfJh7bRRm+8SNuCBDBgP8tyUkSvdwvXIxycOmCdbxsIYngplWz0mN9CT9oo5wdWLSYGILpGG780tn3Ryo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746807586; c=relaxed/simple;
	bh=nuZysdXq7nOnE0VBFR6UJOjGIN3aYFhDt0WDvBmJ1jM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ace8c2GSXDqW4NqYIq0hO7nEa8ESD95HBXmpod0IyVwLAUv0588Rg9I7ecnNuO/r+BvDFiCfc4WlLr1UxXq8utH1ZJhFfmt6/0vg4u+WzwvB0r8BBN6nKQVsfch4RKlvn26Pqr4w/tHJAN8MIkbBSVhh4cN1DO9ZSWii2qCWWaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZtE6me9u; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZtE6me9u"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso454220466b.0
        for <linux-modules@vger.kernel.org>; Fri, 09 May 2025 09:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1746807582; x=1747412382; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rrAr9gNCFzbksNQwY8jdv6TV8DefUAd1zCCFiYDNNAk=;
        b=ZtE6me9ufZc4uj7BHfTrTcMOoJlzUZ3n+hx5f1mJqpbHvUHZ74ba/SHFpz1xDkjtca
         4yuNbgpatP/OKh8YFkzT4zdO2C4iUr21AOtlRTZbXKdNoOCHeCXuZS+u3vY5XR2dkw5A
         qTKMFUCSxPsS9hFmWyk5DMk17KapAfTI0sk+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746807582; x=1747412382;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rrAr9gNCFzbksNQwY8jdv6TV8DefUAd1zCCFiYDNNAk=;
        b=MUDHtDgzjKqqblzE6432XtXhlGf14P67tpzyWuIQU5IdQ5pIdqCah6KVoiy7qnNpU0
         BH5NDL8l42dk1o3CUb0ni9VRnkcbSM/Zt9JmcTRctoqWO6PcSs6YuXU2ntesB++06uSi
         g+66DbDnxF5YzIRCYbzA+eYzDO492nRoWrWFHN1VgUtvzB2L+er5rp1S0pzkLZ5Nfxyt
         6c3mJPeRlSrEkpAH8zxTJbwchxSI2tJBPfTDnLOtXK036xPSSUxAqZi8a2eENhI2pbVQ
         HAJGbgYr7uVx8IxcMnOe7EMXXNndvdleSr3y+fvRoX9BJWtvZMuEsNDkdypzfQZ9X/32
         eqrA==
X-Forwarded-Encrypted: i=1; AJvYcCUGy6/p/6KsNkGHzfgHe3iOgOM3euoe/p2Ayh6VPct6q+VTibndDA4DgUmBAnj2VNYKv0gjUPilk/UWS0Fm@vger.kernel.org
X-Gm-Message-State: AOJu0Yw83gyB9q9WfbxzwcODZMbbj1o32JNri4yHUkBGAr8Ofr4HR3Cz
	5mIxzfR5QzKryMSh+v3+NHp9309wbAN8wJqAKQP3aU2gXH8w0D9NJHUkpOWIL1Mpyle7TJFWd4o
	ioGA=
X-Gm-Gg: ASbGnct6eK3mRO3aPd1yDTf7xHUc1KFsSOuXp4ScFafCFu4sD2S2SKZPuvPEJISq1aK
	c5UeGiJWfc8Qse7tJFt5zE2IE5gYPBheBSnWOwqeoVkF9Ef7bAM8mU6UOyLJdZKqKf96gd3bTvR
	9s8JCn0tVmhVmIegqLfZLkKjYUvK7IaWMOo5gAQPU/Azctzh3adNTSZmvclnnfFnqVm5rZBsx57
	QzRb9R2M6pCE3RxUS2A5Q3x7GdON20YHkVtHT+HlEjwYkfzY5RHYim8cvUJzLWvZB66U/xYT7s/
	Udeo5CJ02b7/SvCNLSYinafsRozN/bTwa19bfWfePXA9hwvH7YcpAGnb3JONy2Awht2zTgajTt3
	vnhiaId84ewmlRs0=
X-Google-Smtp-Source: AGHT+IHstCJo+dClOdmmRSRo0POv/4XKCSthhvboqL9u5s0EgtBq8Ssy8d7SHkYZ88A4Mv3M9oHG3A==
X-Received: by 2002:a17:906:bf46:b0:ac7:3a23:569c with SMTP id a640c23a62f3a-ad218e941a3mr414853466b.1.1746807581780;
        Fri, 09 May 2025 09:19:41 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad224531152sm96122766b.38.2025.05.09.09.19.41
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 09:19:41 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so4113956a12.0
        for <linux-modules@vger.kernel.org>; Fri, 09 May 2025 09:19:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGaEiF9KoY/jXELVZ1RH0tlZa3Ysd2VvqU5uH2Er1H7FjaH5E3cobdAoIJmm2U/nwEnkWZhKLrgFOAKfur@vger.kernel.org
X-Received: by 2002:a05:6402:50c6:b0:5fc:9759:395d with SMTP id
 4fb4d7f45d1cf-5fca0759b23mr3944959a12.11.1746807580754; Fri, 09 May 2025
 09:19:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0e82be0f-a305-4aba-b9ab-79596f595277@suse.com>
In-Reply-To: <0e82be0f-a305-4aba-b9ab-79596f595277@suse.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 May 2025 09:19:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjNj0vHh9v6-LTrbgtq=o6OS+RN3u3m03nV3n9V+urGtg@mail.gmail.com>
X-Gm-Features: ATxdqUE930vvXDaPhP3I929-LAWLeqQARrCJt4USO-NUSGrkJQtb4j3_xdmwKes
Message-ID: <CAHk-=wjNj0vHh9v6-LTrbgtq=o6OS+RN3u3m03nV3n9V+urGtg@mail.gmail.com>
Subject: Re: [GIT PULL] Modules fixes for v6.15-rc6
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dmitry Antipov <dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 May 2025 at 08:09, Petr Pavlu <petr.pavlu@suse.com> wrote:
>
> The fix has been on modules-next only since yesterday but should be safe.

Hmm.

At a minimum, the *description* of this bug is garbage.

It talks about an "uninitialized completion pointer", but then the fix
actually depends on it being initialized - just initialized to NULL.

I do believe that it always is initialized, and I have pulled this.
but I really think the explanations here are actively misleading.

Because there's a big difference between "uninitialized" and "not
pointing to a completion".

               Linus
