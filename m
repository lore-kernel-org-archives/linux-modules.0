Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC1B2206B2
	for <linux-modules@vger.kernel.org>; Fri,  6 Dec 2024 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733510127; cv=none; b=pWpEwkCKMxsDGHcnpm8iR3Uha7AK6KdyVdAoW49Wz9O5Otp9geDRndLaHzmzaZcE/O7OOZ4DF2Np5LFyEGVF6es6bHlWFc4YGCKsUHtU6SiInXy+eXWheEUnhA4iE4/ubIx0Q2hNLP5CHyE72cJn1aaYjpmFTj7iQ/KU2Vpy/TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733510127; c=relaxed/simple;
	bh=wzpjYdhqWb1rGgA+p5a6q4wu+gZ7ZC4urvHFxZ38tDo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BrL7P2FLxX85VZ78WQ7ztgVNYQQfEqNz0yzxqmoWHzPlOZcUe8QbBboGk0rmgyF8jUmHJMDePkscwjGbSmf4MWFNWBDHUjeBBVzExKGEHodY3YoKZyFv0mMDX7CqBwW/aDeLJGbjRQHJmOBr1ZIN8+91s/kYEPoQZr33TvnEkWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CqdVkASk; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CqdVkASk"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7251424982fso2100797b3a.0
        for <linux-modules@vger.kernel.org>; Fri, 06 Dec 2024 10:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733510125; x=1734114925; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=99Zz5f/H6ibQkY7huXSHXBRThasJh30JvvRH9U9jCs0=;
        b=CqdVkASkmOb06BW9Ad3QEvKaOi5tAuDLJK74Uw5CPluxIBtA2nH6zasMNwudVybZ5i
         pS+LT7Ck4RJFnm3XVOol1yvw2T8T7NZa8CIaatdg2/6bLMSk4OHP/sbJ8XorLJNnfu0l
         eBO7sbcsme3ALJeM5SMY+bbiDi2OyX0gN+Ic5nl1CFnFF8cyQCM7Rhoeq/DoOvhnMIx/
         EKzC9bFBX5c/Dxp7GyQq9f+dInS8Y6JbzDs0PFRY158eKH6M1KX7VJEbHSIreVZXF+5x
         XqOOIqr0CGN5IznAaA4kzXxo4/iKwuCPxKoeLLYZFBozGKLJqT9hGQSkH1e12AtxHTDH
         jS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733510125; x=1734114925;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=99Zz5f/H6ibQkY7huXSHXBRThasJh30JvvRH9U9jCs0=;
        b=pmFWWsUImwOo6+pyiR1hxLPorENLnAqiZdaUqO6LkBTvbm+jyLT3t54bAIZoO+o2RO
         h7u3kiAOInXMx83gO83GK4GF3gMuNLxieeNxi1CYwfDv6/XnepDjnNo/yVJ0FkoEhgc+
         f95AWSz7pVBTwH0fKg5YFNlgvj9staiq/W49PuZB64cPX+nJ1+4IR7quknDhEfAyU8c6
         sKM85bBp3LK3nXytNvflcss0p8TNGBASEruRk5iP8kiIAhJEE54e7qtswqGjh2BS1x8y
         PFNGHXzv9AnjS4cWgu2z2wFbN9w6AGcvaiT+eaL7zWnfMV1Gf+3yofkKY6GnQYqaw9Th
         oxiw==
X-Forwarded-Encrypted: i=1; AJvYcCVeBPDgkw6TTQuG5Vqeas/Z612+KskKiwdDd9z8C3JByX61YhXCBUWjI8kXtG6FR55bhbZUI/CmD1YnZOzb@vger.kernel.org
X-Gm-Message-State: AOJu0YwZBnyi+PdhCnOK9RYS1bpwoHtqNBgj4HRqun7ciqu7J/gth1iI
	4uoztRjjgjJ09M8J62AzpnfYHRdmxpMHThXrZorAZ7A5dFYYjNJic/DotNMzKJH3rfe612JinLh
	cxQ==
X-Google-Smtp-Source: AGHT+IE6ZCrRnsbz0XhrD+ntrvvwA8rId9km4rjw1Dc0QnWn1aOrxqVe/kOoLQs4Rde2UPM/VMVd0rEyCrk=
X-Received: from plblv14.prod.google.com ([2002:a17:903:2a8e:b0:20c:5d5a:9d64])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1247:b0:215:7b06:90ca
 with SMTP id d9443c01a7336-21614d4535amr52993735ad.17.1733510125237; Fri, 06
 Dec 2024 10:35:25 -0800 (PST)
Date: Fri, 6 Dec 2024 10:35:23 -0800
In-Reply-To: <20241202150810.606849101@infradead.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241202145946.108093528@infradead.org> <20241202150810.606849101@infradead.org>
Message-ID: <Z1ND6-lK_Yh5PVpU@google.com>
Subject: Re: [PATCH -v2 6/7] module: Account for the build time module name mangling
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mcgrof@kernel.org, x86@kernel.org, hpa@zytor.com, petr.pavlu@suse.com, 
	samitolvanen@google.com, da.gomez@samsung.com, masahiroy@kernel.org, 
	nathan@kernel.org, nicolas@fjasle.eu, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	hch@infradead.org, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Dec 02, 2024, Peter Zijlstra wrote:
> Sean noted that scripts/Makefile.lib:name-fix-token rule will mangle
> the module name with s/-/_/g.
> 
> Since this happens late in the build, only the kernel needs to bother
> with this, the modpost tool still sees the original name.
> 
> Reported-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

Tested-by: Sean Christopherson <seanjc@google.com>
