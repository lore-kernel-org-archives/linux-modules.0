Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED81A3090D5
	for <linux-modules@vger.kernel.org>; Thu,  6 Nov 2025 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419138; cv=none; b=aWA6iv6mru7+8PS5Ai0WZ0Ijs7NunVR2+UwZEXFHMIoEFCxXbw0C3TbzqG2cbL5GXDMpsXTuuOh56Z7/4a8tDvSPprQg5D9M3gj81QT8zIu3AVQ53GcfZsqy4XkI3eXUqv4cL6+isPxeSmvsV/OIly6txMcnDtPYlpDGN28pT1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419138; c=relaxed/simple;
	bh=uZWUHAju2MgIXw9KZYZtVjROBBtGB95ey+E8B9tXjfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cqP0Gg/qWpvXx3TsN4MZewmWkTom30W5u80mwzyMCr/vO6W9ZEJGOwCBn6z2MyDDdL60bkcUWYoorKSC1DG8zEVJswQZ2A/toaZ/MN/CcOYJuZhGQfngwB2GIoiGTW9LctT+SPiNgLlZPVoJUDwohNT/f1TJszC1DEYRbrEQ0Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=esRVAz9Y; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="esRVAz9Y"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42557c5cedcso366125f8f.0
        for <linux-modules@vger.kernel.org>; Thu, 06 Nov 2025 00:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762419135; x=1763023935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kYov8Dro2WY5QRaXiqC8LkQqfmaaDXZFDPXwFxciwfo=;
        b=esRVAz9Yygt3hCuqZcxTgYQDNVH6rKsFXX/4Qdu3oBhnLt2qzJ+mSipYUGcLYg96O3
         8uvzXBlsvQCMvhD5Ld7pw5FxjXpmOdgC7TcgAeywG6sE+OloGd7nmuTdzPcUYrRuBmlW
         vtd9IBArDUsG/hN2uL1WoUmzRVETiKq5jfKW3yW4kzHed9AqSpoWQ3R44gZ7PJXVq1ER
         3U7T98Vo5pt4Ify0M8ja8o/LPdROBqF0i3UyHuva97V0lDQAIUEeXYiiNNQ8mz85rXaE
         QSCb494oJZIVwv9z0sGV4fR1SJf5F/OuHxuiJTAcHHpyKKn3NPiGTswpLIC9OfN8+eFf
         ESOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762419135; x=1763023935;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kYov8Dro2WY5QRaXiqC8LkQqfmaaDXZFDPXwFxciwfo=;
        b=RmisV8QuH/GymSpXKRJOBD2vNf15yG3iBMtFJsS/+63NKddQ1oDY+fnTBdBGdm0mic
         UQI+0huLOe1Em/aFnpZs2ETXiFMr9XnJt5FqbPy0/o96vveisMmx+4hOXmSglXHy3mOy
         BmK4xujCfQJthVG3JJzmBxjU3RFtApDkDWLnUSW3IfMo7Is6TuqhTjqxIxBSixl/6DjO
         DnBipC9P/LqeCrKDIcv5403cFLv+qsTzK+ea0f9p2mlBr9m2K9aRB+zqSC0myUgStLE5
         xY6Fv7OEUDNGw13DLZTeMqpyoMFJKpoBUAiljRvfXsMUQ2ySc+uh0Yl+/glQD4WIYPob
         BNWg==
X-Forwarded-Encrypted: i=1; AJvYcCXxElt0VdMqpP2U4H3nZRY8KsomFq4h8tFsx31NkECrMgF3dAO83AUMPUYOZ+W/0Z8jcyqgD4jK4cyi0fcR@vger.kernel.org
X-Gm-Message-State: AOJu0YyPZFtC5phIRmMK+W2p9qtfoCSZrzrHjlou75tlkYUnJBXxnpsL
	6qkBs3B0xnNSoJQQIYJ6Y951V5+KL2uf8GlZLoif4UJJ8bmN89n8l7oeHEnThyQAzUQ=
X-Gm-Gg: ASbGncvGZLUp3fdz+rFKGjqkDvm8L0FfPAHZuGC9YqlDgOgtHbS8erDPhwn3QQT+syw
	D/5hynfOU7MZiU13eRLrb85BffdO8Y+cUOWfREIIL437cmUKbrEeQXcR7oVlQ7qYspJ1mUSKieJ
	mLh8Y6QHp2xJBkfEHLNbrYrW1AbEJxIrr7IbqE79+okimwy+Env2j6+sfjIFzSfLmpFEvOZEPVa
	C/tQ7nnPb+Mr39i5+LLVZAJv7RhXTwt1QCgQ0X2+FTf1aAVtKT7Zy1Ij98ca8mlBaBeun0csIx8
	T8DwdDrAl/IjzHS4JixHnZJXT13/aPFCFe5UHEfygO1rSSuXVRBHsSBqqpMAR9p8SeVj1hxgTM1
	+PKIOykvjbpHcTPfBEy7rTBj7FovbdG1xDs0tJ07qMa7nKvpmvb1mFg/4osOOVyPbIk6NPto1Cd
	xiJiWBNdrVYSrQTH3h6wpGtgm7/UxHGLpIqoIHtdUUyZA=
X-Google-Smtp-Source: AGHT+IE4MYS5Wr19GhmhPW/lBh+nmvHM2VktPve27rlVGZM2YL1NCWMjNGClTXGoBm0OuhF858f5xQ==
X-Received: by 2002:a05:6000:22ca:b0:429:d4e1:cbb5 with SMTP id ffacd0b85a97d-429e32c4b31mr4414987f8f.8.1762419135296;
        Thu, 06 Nov 2025 00:52:15 -0800 (PST)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb4771cfsm3584100f8f.30.2025.11.06.00.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 00:52:14 -0800 (PST)
Message-ID: <1b7d3311-764f-4e73-94ca-74dd508d1113@suse.com>
Date: Thu, 6 Nov 2025 09:52:13 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] module: Add helper function for reading
 module_buildid()
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov
 <ast@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Kees Cook <kees@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20251105142319.1139183-1-pmladek@suse.com>
 <20251105142319.1139183-2-pmladek@suse.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20251105142319.1139183-2-pmladek@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/25 3:23 PM, Petr Mladek wrote:
> Add a helper function for reading the optional "build_id" member
> of struct module. It is going to be used also in
> ftrace_mod_address_lookup().
> 
> Use "#ifdef" instead of "#if IS_ENABLED()" to match the declaration
> of the optional field in struct module.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
