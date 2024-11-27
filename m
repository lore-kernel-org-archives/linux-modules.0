Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6471915E5CA
	for <linux-modules@vger.kernel.org>; Wed, 27 Nov 2024 23:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732751830; cv=none; b=RG4QPi5lwqmprMwlLwN4UogNKgWFFY4rYOk6LcxupftdNMa4ckqy3fSaV37Wfx4E5TX+SHpF1H764N3vd9LtzgRkF1vlYkFLcY2Op9wpmIix46KOd/edOrZbDPUvGd36TW29eCv+BetL9HTCmSe78E/6s4BL3b68RxSq5uGdSMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732751830; c=relaxed/simple;
	bh=gThBsz3+hRwi0ezlPl0OHla0tdLsXvJYTiWleIRrU+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mtg1bCtQtb8JMa8Q0+AQh3nkuY5V8u93qPcDTRET1l3rshH90NY1JrwDjwbwkQSa2GSh+QAkmyjvrZtQFI+N/aP9VC8C2sqKa5dEe7PgCIQkVKBl4ZFVgyKLpum+wqy6H7M9Q3VRbWse99TrmymKe8770TaqCr+kRMwrmSOg7gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Pz8GEAfm; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Pz8GEAfm"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa51bf95ce1so40789566b.3
        for <linux-modules@vger.kernel.org>; Wed, 27 Nov 2024 15:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732751826; x=1733356626; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KPlRZAjURNuIqI+1cp/M1BdMXf3esRQ0x/UNttbDRTI=;
        b=Pz8GEAfm+bnwKmOHXwwL36U8EU8oQwoUFck2k6J+hC4Lhy645Iz8z27fQmqhRLpKkY
         68WCyqjY1Fk5i8asdt5rJ2IUDiGeRHGZV7rEAPVGTfg/7s2azo0dzxEskGMbZN224YbD
         HJHnvx+P0+KqL2zrZGkDE9jA8PyGKyRxprjp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732751826; x=1733356626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KPlRZAjURNuIqI+1cp/M1BdMXf3esRQ0x/UNttbDRTI=;
        b=qsA+CCZoy2QxQF9zGLwRsxUDJPqe2qdZkWOvR6ZdBz3ViG8JS2wOfGnPlOybyh8ZFb
         +XbT/imaNsrPhvAG4VT7Vx2CJyJdarSLSI5F0mOlwSXP3XbczEgoThLSGPo3yBy65VFA
         k67j8bVtZsXc25xk419LZcE24r6BYI4S1eteh83NJHjdLiylrgOPtCwTYwW3sY9UjP1h
         AihSGZ/BnLSLCOpzUWhHBWt5wbO68GZ1cjKqgS9pKUicW2wRARAQ8rDDQ1o+nU2cnrFD
         tSCIEburPRpoK4+CpLYgX+MPaGEVgDyvFm8nCx+wqUoHUS+kHm0S4YDsoWTYXQB0cIzB
         O/Nw==
X-Forwarded-Encrypted: i=1; AJvYcCU5BVgfauQExGrvr3Cl5OBSDnMU5v79iqXyWseGpL/5qeMlMwhfhp94nDYsgwCAn8nt9ap693bpwmwzy9ne@vger.kernel.org
X-Gm-Message-State: AOJu0YyY2e3kSBrB7SHKT0pp+XKYoZO5+gVD1o5YjVnJNrXkRlHFAWB6
	KNtXki6O5lFWEOcBeenYvdPZ66kqe8FlbJieM1gpdtwx+8Mo1bXRYzN3/MGNmZBm3hwUIjhYxeM
	TyzY=
X-Gm-Gg: ASbGncv7i116jIgWsisfDc3KTP4pcq8MCtFyeyr+SgVCCeiNl4Kba1vwnJpAdHxpKfu
	Ccgwe8Qy3v2Q5b+AoqAq4mrQk3NZh5FxmWbppb0IOvBpPUG83AF4MltcNDNXWWbF3XixX9X5uA/
	b3lQXwCa4RdQiIKgZief9Jw/RGQjYNHdxzAdt9TA12IwZOD7PHkwghRFdKJvy1w2L/9AkM2c7sV
	rjnubpyU/fC5pCUHFVYOlkgfVQUC5U1BqBkmX5jDlXIh9+H6//f/DyEFV2o8smA1salboANc++K
	QV00u6nkOUX7U2sX1N1QbQ9Y
X-Google-Smtp-Source: AGHT+IFKKIGkAbSqZu1OaIIp2dX+pICR7y36zqxZu9T2jeUDZY/OOSzyDEcjb7FvsWVAmvAtyOaaWw==
X-Received: by 2002:a17:907:7802:b0:a9e:441c:f729 with SMTP id a640c23a62f3a-aa580b2e09dmr532302966b.0.1732751826525;
        Wed, 27 Nov 2024 15:57:06 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5997d4124sm5675466b.64.2024.11.27.15.57.05
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 15:57:06 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so42941166b.0
        for <linux-modules@vger.kernel.org>; Wed, 27 Nov 2024 15:57:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUhDGmpsNC6vWsonfig9QEBYbe3U31pnxB1MNmHWSliufq1X/2aqt17OMFEsg6vH2bGvFe3MQCiK2DWzrK2@vger.kernel.org
X-Received: by 2002:a17:907:7754:b0:aa5:1da6:d4f2 with SMTP id
 a640c23a62f3a-aa580f22baamr487890266b.22.1732751824877; Wed, 27 Nov 2024
 15:57:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z0ZxiLw9hauUynTS@bombadil.infradead.org> <CAHk-=wjCkJsdLageTx6C4n--aYFoO6gSRe0Rwcbk1jQdOdiPfg@mail.gmail.com>
 <Z0eeuCyUGcKgsc5h@bombadil.infradead.org> <Z0eqiayuv1w4a_dc@bombadil.infradead.org>
In-Reply-To: <Z0eqiayuv1w4a_dc@bombadil.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 27 Nov 2024 15:56:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj+imfGvW73XoYn60bAMzRtPfXFqwFTUqBoEq4=u5_oUg@mail.gmail.com>
Message-ID: <CAHk-=wj+imfGvW73XoYn60bAMzRtPfXFqwFTUqBoEq4=u5_oUg@mail.gmail.com>
Subject: Re: [GIT PULL] Modules changes for v6.13-rc1
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: samitolvanen@google.com, petr.pavlu@suse.com, da.gomez@samsung.com, 
	linux-modules@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, masahiroy@kernel.org, mmaurer@google.com, 
	arnd@arndb.de, deller@gmx.de, song@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Nov 2024 at 15:26, Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Nov 27, 2024 at 02:35:36PM -0800, Luis Chamberlain wrote:
> > Sorry about that, I'm on it.
>
> OK here is a fix, goes double build tested and then run time tested.

No, you misunderstand.

I don't mind the tests being built. That's *good*.

I mind them being built *twice*. That means that there's some
seriously broken lack of dependency logic.

            Linus
