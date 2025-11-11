Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0F236C5A0
	for <linux-modules@vger.kernel.org>; Tue, 11 Nov 2025 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762877994; cv=none; b=aaViAbnumGe+6V+kUTY2akfmDuHFLB7QjEi0p7uAnjIaK6L1wI10hARHECnURO8zCZGhF5EADVo656u1dF++5R9w6fmI5meRWTVpLDJuHCuw0Tn7ou2L02AuR17VHx0cFA4/BzvY+t/RvKAE8u6nE5YO/ms6A79AibVwCJJwmH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762877994; c=relaxed/simple;
	bh=Bc4SI9w8LgTzpLMjF+skEkrQD/NC/Se0GkBwuligeNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BdOwfjL5yLrtqi8/7WakT+RYECQE79N0HIuSqmU2r0fMiT8IBFSrGnvuqWpyyZHYqBLs8quq2gXz42JePRU7d9uQ3hg/z4MBKiy7+WPbOCLFF1+T763wTrtsB9nmFeud3eUKjQdlen0KcrxfI0f24sm8oQvkQJQwT7M4qY6avxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dGEbh37L; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dGEbh37L"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-429c7e438a8so3846159f8f.2
        for <linux-modules@vger.kernel.org>; Tue, 11 Nov 2025 08:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762877989; x=1763482789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v95Lu9O+J54/kvSSdJJQyXoIt+hwqt0CDtnCjONZJ6s=;
        b=dGEbh37L4PrqMXbctH83QTLmZBRD9bYOYN+MyQ4OPvBaWCPR9eqgBCE8Dwin0CU+fj
         nHQr/1ms4cROE5d8WloGGM2PoLl7YeI5oXPSfakIbFoO+rpa9cSVzp28Qlp+gLGyJEO+
         HWyMwg3VXJ79//lrbUxLRKe9pIsAYogO34TceCTkuCNaIrQCUi8u+GcWh21dxh1sENfF
         CsNHCCbcVWJOQDIngh46AqNg3TYYTtoeoMgybD+09wdqgJeZmNZAIMybRUtpcboLdJra
         EciyUMdqfkg6TlkjyXnUnMmsmNsRfqHLNBOz2jO/U9uWdpukR8oPmdq9YGKkpbONmmfo
         618Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762877989; x=1763482789;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v95Lu9O+J54/kvSSdJJQyXoIt+hwqt0CDtnCjONZJ6s=;
        b=I4Bmhb2bLB8CZTsMJ5laQ4w522iOET2aVDHV+5CdFldkbTN5IdX2yTNY+sU1HT/rMM
         7EQxgukKKNGPWIVz8kWu1XpbxmIZTdFxqoGBue7WSjrviDC4Q9hxJZ78mJ6GNKVMgBfC
         iwS3zdZCPzmsKNPVs1nVQwS6dRqVI8eKHNokqoVWtMQI7/GrgMRg+S/xG4bz446ax3Ga
         bfnckWH3ITNCHu9eXfjYpeqA4chCrItCYzrqash5Rm9A0MZ+KdQzIReBj5aD6nH97MJc
         Rz66NRjRlSUgAG8FKzXvA8rCE1Db2licbIpRnE4SgE1X2Pk5uEk5bm3wAuJtG9idPfVO
         T+ag==
X-Forwarded-Encrypted: i=1; AJvYcCWDVupPUHDpo/43DLOV6xB071odJfHGzv5eejJqLnPW2lXG75ccXoSOExL51IJMA6uYfrTkrV/6xYtzO2zd@vger.kernel.org
X-Gm-Message-State: AOJu0YyszgRMucM0QovdEvOfYGdmnnXNpGoiVeTUfG4Xk8U5NcUebzfv
	jVOk0PDUqd3x6mNN/zdx1pTUh4v8LMjibn/shU1D+awqo2iwDeAiCN38a0B9sQyED7U=
X-Gm-Gg: ASbGncsx+d3SrliEimYM3pyYck0Lt6xCiAnVhpncNOprhwAvr63koAUqL3EDbZ9E3o+
	Bf2PDz1W66AteTnX5fC8w2iQJbUWyh2Sy9YcHfUBXrpW0Qv8CPC04xUiELpY27R+Kv+w1HRosEC
	ImFbVS8tcF1M5/xwxzYnsawCWpd5EkEX5TMn83W0Sg1V/MWc4EzJlEEkPr0xNXDGVi1sU4Ixo3H
	6mFM65KCMJnEfwC8NKTBP3bHmDgOK5kGAx+KRubhXUVlLmnST6pyvE/AISQ7v8zC8VF9mAYt8vu
	ljEtd+kE+o/4cicEChU8vXDziASQtb/9c16fgxBGx5SWLriD4WNrT/Wf0t73fOE0GFp9InqFZEc
	c8/AO9qgplyAtJw4MHNBcCEOOKtpsTbhTaIFFAE3OLY/2iy9cYcvhvo44jSgKVJBzAYUAEZE1cH
	Mnl/4H98YweC0rYhKCkFtyPg==
X-Google-Smtp-Source: AGHT+IEPPEd8LCwY4ekm7MuVxGB6HrGTZQh1dtIfFSvNPwBOqBabYsVqP6nTgfnxaPkeMZhtrnoUeQ==
X-Received: by 2002:a05:6000:2dc8:b0:42b:4267:83e9 with SMTP id ffacd0b85a97d-42b4267873dmr3443167f8f.2.1762877989161;
        Tue, 11 Nov 2025 08:19:49 -0800 (PST)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe63e131sm29044313f8f.20.2025.11.11.08.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 08:19:48 -0800 (PST)
Message-ID: <947d2119-1061-4cac-9bb9-4c8b0e6e5b65@suse.com>
Date: Tue, 11 Nov 2025 17:19:48 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] module: replace use of system_wq with system_dfl_wq
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: Daniel Gomez <da.gomez@kernel.org>, Tejun Heo <tj@kernel.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
References: <20251111095049.67658-1-marco.crivellari@suse.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20251111095049.67658-1-marco.crivellari@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/25 10:50 AM, Marco Crivellari wrote:
> Currently if a user enqueues a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> 
> This lack of consistency cannot be addressed without refactoring the API.
> 
> This continues the effort to refactor workqueue APIs, which began with
> the introduction of new workqueues and a new alloc_workqueue flag in:
> 
> commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
> commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> Switch to using system_dfl_wq, the new unbound workqueue, because the
> users do not benefit from a per-cpu workqueue.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
