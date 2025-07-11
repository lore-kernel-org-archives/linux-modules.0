Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF442E5B2A;
	Fri, 11 Jul 2025 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752242787; cv=none; b=FCd7h0tOhzgNAZCNi3Ay32absyeSK8gdQni331aepCfz2LaboSyVmM+uBntRnZq+uHSRYGuONtA+fC320/vfA5jdmxpuX7tACmodIuLTypGxfjaz3qneUF8UW388uMEyP6mKuwRRhJELdUhX/OShJwNNEvsy6kzyaEJlhWja6vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752242787; c=relaxed/simple;
	bh=rha5rNd/+/z1arNhONh6XrU13+BFec0/iI8Uq17rXic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kSB18/UlmKJNCjOepyc9Sw5piBbSOVDpyfnZeH9Vro/UoHQi9fdlhWe4HeAOqJY1h3MhfxuiJvYRBqmmfSRcHXKGG/Q/kt1dWvS9c8UdHdPL2zv3DG+sdZfWB/z1lWPbmfl+4IMZUGgfKyUnmnIJ+/Aq/i5gT4gWXPRw76/x4qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLdx/4Ht; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLdx/4Ht"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0512CC4CEED;
	Fri, 11 Jul 2025 14:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752242787;
	bh=rha5rNd/+/z1arNhONh6XrU13+BFec0/iI8Uq17rXic=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PLdx/4Htfxna1tnlXVPnyLI6Z2pQUJAyWz4Scj3eP5P9+viOIwVQE4MdVt8ru9HUY
	 Nzbb6CTVVGOe4H1J7jcn+g/wwHV+KTb9yJdRZ4AYnyj4qXPHN2YpMuY31+ytxJqt3A
	 Bxgasc+mCTAO3y3mkapu2hj+/dLedbir4aaFbBrmh3bOTWiBA5WkmSI1ocJR73PSOB
	 Ua52gJAWd/9R3Z1drRHFs2yGfs+GCU3AUPnOzzVTcDXYP5Gqqtc7xSY55EbTJItjHk
	 +lf3VUS5zYNc6nuTX9pw07E9i3v5K1Ok015iENHrfevGwNbVSpYhZ0jlo5UCrX7kdX
	 btO+hAWBsz6Ig==
Message-ID: <2acf7211-e481-4320-b6dd-08b3fa2e48c6@kernel.org>
Date: Fri, 11 Jul 2025 16:06:23 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH v2 0/3] module: make structure definitions always visible
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Daniel Gomez <da.gomez@samsung.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <20250711-kunit-ifdef-modules-v2-0-39443decb1f8@linutronix.de>
 <175224114462.57001.15162198119283395382.b4-ty@samsung.com>
 <20250711155016-f403d5b2-478d-4666-913d-45318cdaa3cf@linutronix.de>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250711155016-f403d5b2-478d-4666-913d-45318cdaa3cf@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/07/2025 15.51, Thomas WeiÃschuh wrote:
> On Fri, Jul 11, 2025 at 03:39:04PM +0200, Daniel Gomez wrote:
>>
>> On Fri, 11 Jul 2025 15:31:35 +0200, Thomas Weißschuh wrote:
>>> Code using IS_ENABLED(CONFIG_MODULES) as a C expression may need access
>>> to the module structure definitions to compile.
>>> Make sure these structure definitions are always visible.
>>>
>>> This will conflict with commit 6bb37af62634 ("module: Move modprobe_path
>>> and modules_disabled ctl_tables into the module subsys") from the sysctl
>>> tree, but the resolution is trivial.
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/3] module: move 'struct module_use' to internal.h
>>       commit: bb02f22eaabc4d878577e2b8c46ed7b6be5f5459
>> [2/3] module: make structure definitions always visible
>>       commit: 02281b559cd1fdfdc8f7eb05bbbe3ab7b35246f0
>> [3/3] kunit: test: Drop CONFIG_MODULE ifdeffery
>>       commit: dffcba8acea3a80b3478750ac32f17bd5345b68e
> 
> Thanks!
> 
> FYI If you apply a patch you need to add yourself to the Signed-off-by chain.
> And Link tags are nice. For example:
> 
> b4 shazam --add-my-sob --add-link

You're correct. I had a lapse there. Branch updated. Thanks!

[1/3] module: move 'struct module_use' to internal.h
      commit: 6633d3a45a8c075193304d12ba10a1771d1dbf10
[2/3] module: make structure definitions always visible
      commit: a55842991352a8b512f40d1424b65c911ffbf6fa
[3/3] kunit: test: Drop CONFIG_MODULE ifdeffery
      commit: 699657e8e50ae967ae26f704f6fbfa598fcb0cef
