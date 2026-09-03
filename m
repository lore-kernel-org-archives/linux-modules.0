Received: from mta1.migadu.com (out-45.mta1.migadu.com [95.215.58.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F376348477
	for <linux-modules@vger.kernel.org>; Thu,  3 Sep 2026 06:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788416962; cv=none; b=LvILcxqMM6W3Op9V8LrNEP6vHYdP8svdvjmQZQkqtuq6sjyhaxZ9I0tQVBLp5tqCGimtHEi9/6nXutKE+K9vh4VBCfM/M8Gist1Tu0Ekja9vWX/79WYIH619DcRzfMJH01LYAs2augGjYHXIgN9B2cJzS7pWfA6heaUDpBr6BD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788416962; c=relaxed/simple;
	bh=w8ONuXQbe+L8t9TFC6e++AV1NKpgPqVNbxHf6dsgfC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VBibs1lkjDufGvsW0oCsHS6Ug7oVfayvg7oY9UpvwnOPsTrQkPitIDGxpVn64d9OhoeK5ZZeoJjQKs4cy9EnA97b+hip73IVX+47GF3zKlMeypq6dMShOItEYLw/joYqxYdgWFJyarlmWHP3NogrIKOytsy7HKfSFSNi1bNp4dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kXh01iXN; arc=none smtp.client-ip=95.215.58.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kXh01iXN"
X-Envelope-To: linux-modules@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=w8ONuXQbe+L8t9TFC6e++AV1NKpgPqVNbxHf6dsgfC4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788416957; v=1; x=1789021757;
 b=kXh01iXNsomvkFcOEM04/ejpATikOaesUf5LcZ9lgj/3h01z5JnXQs50kGWEbTxz1sWnkoTy
 Fl9P8Pup12qkBVB7tFRNh8gCLXPxV3QfWFrFqwE9dho6MrXmklF92ltLMAQbOE6Irrn1B/k9/jD
 zUI1ebe3j+jLQnJKHJi7octs=
X-Envelope-To: linux-modules@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1d69a6012f25cc1f;
	Thu, 03 Sep 2026 06:29:17 +0000
X-Mizu-Trace-ID: 1d69a6012f25cc1f
X-Migadu-Flow: FLOW_OUT
Message-ID: <336b56b2-6a00-4153-8c0f-19272bcea383@linux.dev>
Date: Thu, 3 Sep 2026 14:30:07 +0800
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/4] alloc_tag and module codetag section fixes
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Suren Baghdasaryan <surenb@google.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20260902081802.146145-1-hao.ge@linux.dev>
 <20260902150501.d589742ba33d0beeb0cdb21f@linux-foundation.org>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <20260902150501.d589742ba33d0beeb0cdb21f@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andrew


On 2026/9/3 06:05, Andrew Morton wrote:
> On Wed,  2 Sep 2026 16:17:58 +0800 Hao Ge <hao.ge@linux.dev> wrote:
> 
>> I ran into an overflow problem in the module tag area. With profiling
>> toggled off, the overflow check in reserve_module_tags() did not
>> run, a module could load with more tags than the page flags can
>> address, and re-enabling profiling then silently corrupted
>> /proc/allocinfo. On overflow the fix shuts profiling down, releases
>> the reservation and returns -EAGAIN, and the codetag section lands
>> as regular module data in the same load, so the module loads without
>> profiling.
>>
>> Review of the earlier series by Sashiko turned up two more problems.
> 
> Thanks.  Sashiko had a lot more to say, as I assume you've seen:
> 	https://sashiko.dev/#/patchset/20260902081802.146145-1-hao.ge@linux.dev
> 

Thanks.

Initially I was confused why Sashiko didn't review this patch on top of mm‑new.
Some of the issues Sashiko reported have already been fixed in mm‑new.
I checked my old reviews and saw other mm‑module patches were using mm‑new.
That makes me wonder if cross‑module changes follow a different baseline.

No big deal, Sashiko did find two valid problems.

> Also, "Based-on-a-patch-by:" isn't a recognized thing, although it's
> been used ~30 times in the past.
> 
> I'm ambivalent about ad-hoc invention of new tags, although it happens
> a lot.  Perhaps it would be better to do
> 
> 
> 	Based on a patch by Petr Pavlu [1].
> 	...
> 	Link: ... [1]
> 
> ?
OK, will do for the next version.

Thanks
Best Regards
Hao
