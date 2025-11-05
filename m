Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0952BE65B;
	Wed,  5 Nov 2025 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367629; cv=none; b=jrbSJFAlVDrCUqZkmGCgzMbmpy5BjNhAKq7gT7jNQMYPG/+ICyR7Y7qbaJLY9he5fYG1iK1BPtUAn3REuhi3ZwtHOUIhZ8WWA+QxhGDghVLek641rDSONqyfK5K8o08gCMH0TdjDLHRTYAu1QTmrCTZ0Q5KdfWz601p/47e1tQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367629; c=relaxed/simple;
	bh=YFKxyVuZsM6HG/F3t9FdW5b8FwJjSF73kfhyb4pt/yY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ejQNPyPPA8AqMZO2y+tA9xDT1JtYboU6E0teRguM0dUxphR6z5pFT2+PXQn1IzXny7J61K2d493fLsbdwyEMUlEPPR4WRki6HnVzul1/+zoxjfGzymBpQXsP3hQcZPSiC1xExyI9F36t8SSd5ppWmwAyia2a3lXcGwryKjbjms4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=dvbVUEqo; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="dvbVUEqo"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0712F40AFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1762367627; bh=+q7RrWIX3Mh1raymNV5H/DL9H5Mk4ZR5qtm5taZ3fIw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dvbVUEqo52D5NCcbZaRNq6y20lKi0tMvABZaZU2HxEA1UDulJ9nJcO9Mhi/PlFjSa
	 ksfs86gahV0eMG6yLwoA+rmBqqd3QllaKVET8YiKyzuY7wZZcTBt8hsBPRu0nC2XxG
	 PZnA6KK5i6jiaSO7cXu27dAw9eb2dROeCG9ko+HmoIxviHvXCCDiHiBiiianIWjAt0
	 3Xugkt4Le9vdEC4vsegFNEOAkacdyJmRoxdFOr5soCunPBdZrFE29ZATbK2sKbAgUV
	 t/hSKD9Ng8L6tluhY9PSK9UFhxfArXHkZ/+M/+uj3kjCiFADyA8Tu3BLALAV0pyT4t
	 CKPgb1K5dg1dA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 0712F40AFB;
	Wed,  5 Nov 2025 18:33:46 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Petr Pavlu <petr.pavlu@suse.com>, Randy Dunlap <rdunlap@infradead.org>
Cc: linux-doc@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel
 Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: ABI: sysfs-module: update modules taint flags
In-Reply-To: <7301b0fa-5463-498f-82a0-f40bfee462ba@suse.com>
References: <20251102060458.517911-1-rdunlap@infradead.org>
 <7301b0fa-5463-498f-82a0-f40bfee462ba@suse.com>
Date: Wed, 05 Nov 2025 11:33:46 -0700
Message-ID: <87tsz85nxx.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Petr Pavlu <petr.pavlu@suse.com> writes:

> On 11/2/25 7:04 AM, Randy Dunlap wrote:
>> Add missing taint flags for loadable modules, as pointed out by
>> Petr Pavlu [1].
>> 
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> [1] https://lore.kernel.org/all/c58152f1-0fbe-4f50-bb61-e2f4c0584025@suse.com/
>> ---
>
> Looks ok to me. I would only move the "[1]" line before the
> "Signed-off-by" tag in the commit message and separate them by an empty
> line. Some tooling might rely on the tags being separately at the end.
> I guess this can be directly adjusted by a maintainer that picks up the
> patch and there is no need to resend it.
>
> Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

I went to do that, and was amused to find that b4 already took care of
it for me ...  applied, thanks.

jon
