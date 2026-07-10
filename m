Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EEA14A8B
	for <linux-modules@vger.kernel.org>; Fri, 10 Jul 2026 07:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783669019; cv=none; b=ukA3uA5INY+01q2ws8aMocuysqU6zSksRK5OOHVE0F4l3v3WPbmPIsvxBWrHIpWCDIlOO6nY7kVUhvPnyap7iTdQhAqwGkSXoRaSRsLh41UqdcqHbWc/PzAXxPwhX/pRrJtIODASnNkFOUj+u2vV0HwdP9Ha28nyvFuXsXB0G2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783669019; c=relaxed/simple;
	bh=/btPz6qzpnNC9zqJ1UbTBJTIBwtZkAiFYU4qDRyDTgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sCvU9GhjtellMsEun/VXYXClTrudjOSstqo+2NoaDVXT3gHrvC5oLlT/bjUpKGg7Jui+gfIG/RpfXYBA4lEox4F85ET2zWRYQhz10j93sqDE8ocjqD6yYiQyo/w6rPOnpf+qbY/NOK0y6BPm6lb1E/Lsrnm0NEwFTsNlbfXg3zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M5kFSb9d; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M5kFSb9d"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493b7612475so4406085e9.3
        for <linux-modules@vger.kernel.org>; Fri, 10 Jul 2026 00:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783669016; x=1784273816; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UsdZjwzhCh/Pi4/lA33EBYHRxIAaJM2CQdOKJtZfFWA=;
        b=M5kFSb9dsybntJrmujFByojHKLK7tRRKAbum6fEEPPfo7aEScIbUTYTNR1EL4d92tM
         C2OnDl7MXk8nyxKh16be98TuhcLTv4tonFT9WCFVTqstNpaEbLEHyGRYb1v4J4s0rBQz
         Ybfcm80djZkjNhizmGE/8qYGce7A86xJww3nWXERZ5XX+dvofSqsFtlPijdV482J6AJQ
         qC81yU5sdl2F0RuY6dvmSXofSgrNI+R3Rs0xhwEEfr34obPnrffXnrp4Hztri2TN3HjW
         swkIUS5awpA5MHcIOgaWzZkW0H+8OABYDhP4vR6M6BNfn//VjS/C8hYmb7slRMW7LOCY
         QK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783669016; x=1784273816;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UsdZjwzhCh/Pi4/lA33EBYHRxIAaJM2CQdOKJtZfFWA=;
        b=GxFhQptNE+1IKw6sq3AkV+QSEtoCPt21+f9esNzdoZvnwjFRw3t+ybKeaKij0GrDga
         QZzvSRw3PbRSnZxzeYVDsyNKNtnlYbMBwzPY/7tXVHABiR+GEY+IqS4L9KAINWmFw+bJ
         Sb/ShcN6kyMwC/FmtjFwQnCEBLp/qS5e0dZIeNohw7sYIVEwdDOlI+UlTEThLDsjlj/T
         1mctpLTDrzzKF6zC9inRSzzrVT+h7JOiFLP4FYWAIFH2vURz+MMJeZIcnJYdL2LGHq9s
         oWfq7zNWEFphY2FQUsPdANtzzp95KB25qr7qbGrQ0sRybn4Da7OHwRp8lJ45bDyYfD/5
         EDbg==
X-Forwarded-Encrypted: i=1; AHgh+RoIfsg3Ky7HfRTQm7UGVR+bPZ/vXRc2DH1tBfiaDZS8hyW282ZRApvDOS1ZN4ekcMxP2Aw3gRHtQdVP0qlE@vger.kernel.org
X-Gm-Message-State: AOJu0YzjHXwefjqjUdB29gJL2y11zaQc8LWGwGBSbzJSqRiRCTOSiaoI
	/GB3ffPC8Yd8NL0NI+rKNXnZ+jVR/hOo5syR96N9jvkLFOOuTjv41SgTOylbNFrwLug=
X-Gm-Gg: AfdE7ckPipAURpl0Yc+01AwDWQAWngZYaqR9N3Jfq4MVZ0i+vw4XXWKbTwgy8xNfkI7
	4oXUGlm8uribDs2ZD8/r88SypNw2DkohO+N6gt1vm0qita3Ydw0sMIq/N/XeIfXHMvzIvhjLFfr
	O1wgAdfa+pZJDbBdGTwExGtdVhvN8cOQ/NmL6Ns22SQun0JBL0LxZ/gpzjxQpJ2/WFA8MFVIvVL
	CIfncj4KfBFd3h2PBXr5moPC5NMxzZMur88xdfdSGMNXT/IsfszBQnY4DY20v+Rsj88i0lv3MOX
	0o+M04cj4hc985jWwRGUpkWvQjhVEHQfHjlrq45BLV4q3TbPc1O31c/rOCxs1kJCkqxeIgeoEku
	fdDSGb4/6vAuforxclNaKMBmRoAPXSYdnV9SvUN6nNelRds5vhdy0ARXVfqdHxhHGkyPDjuOZzq
	ZpffcsH7XHrDpXRaQoo1wKGr2+p6oRckIkZg==
X-Received: by 2002:a05:600c:6211:b0:493:dcad:84da with SMTP id 5b1f17b1804b1-493e683c3b2mr94779765e9.1.1783669015948;
        Fri, 10 Jul 2026 00:36:55 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6df6d9sm130933095e9.7.2026.07.10.00.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 00:36:55 -0700 (PDT)
Message-ID: <42fc10b8-1d75-409a-b57c-e778930c6186@suse.com>
Date: Fri, 10 Jul 2026 09:36:55 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] module: procfs: fix signed integer overflow in
 module_total_size()
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, mcgrof@kernel.org,
 da.gomez@kernel.org, atomlin@atomlin.com, linux-modules@vger.kernel.org
References: <bl63xtwmzo42pw4636lr75u7duhuejp5tariokl27x3wnvdu24@3xf5cupsskka>
 <833ca499-09aa-4eca-a023-e3a7168066ed@suse.com>
 <CABCJKuczwBmtKXiyzh31Efwbt6VfwUpStLPjXkUFNHwwSPQA5g@mail.gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <CABCJKuczwBmtKXiyzh31Efwbt6VfwUpStLPjXkUFNHwwSPQA5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/9/26 5:25 PM, Sami Tolvanen wrote:
> On Thu, Jul 9, 2026 at 1:45 AM Petr Pavlu <petr.pavlu@suse.com> wrote:
>>
>> On 6/7/26 6:18 AM, Naveen Kumar Chaudhary wrote:
>>> module_total_size() returns unsigned int but uses a signed int
>>> accumulator. While the result is numerically correct, the type
>>> mismatch is misleading.
>>>
>>> Change the accumulator to unsigned int to match the return type.
>>>
>>> Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
>>
>> Queued on modules-next for v7.3-rc1.
> 
> Note that the commit title still claims to fix a signed integer
> overflow, which isn't accurate. Otherwise LGTM.

Thanks for noticing this. I tweaked the title to:

module: procfs: use matching type for accumulator in module_total_size()

-- Petr
