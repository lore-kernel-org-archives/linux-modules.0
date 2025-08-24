Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8708524467F;
	Sun, 24 Aug 2025 07:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756018808; cv=none; b=ZDxQfzWs8zqkv1qbZLbCfI3IyD8dakJ4Wu1SpZ20aybHQQFWCQe2nKaKAZ+qBUzCaK6UPFGQ/z9Uw/nDaPBbbwGQK4P07FtchWTWj2t0OURSSiRBUYAQNi+Fie3iNGMsN7Ply3QQbIOktnHIVAOb95lNvr4ihPEA0baGqeNEXl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756018808; c=relaxed/simple;
	bh=hBFIZ04UzgQBlo5Sx1B81eWI+Zc3+ZZtAl2/5tzYiD8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=X2nnYz1kGfvyqtz2oSMQm6LivgPWSyW+PqJQycZxZ/en+ibFRoSb277oSMcX4wxtKuDvBNo0oI/UvRLnSOuUhTUqrHEF7R/AWoGO71QnGvni/NHU4VoueniK5gyCs4hI5cI8uZiFO7qDRSjSAjWo3GJqEIZscdf0CC4yU3pECn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EosBavdT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EosBavdT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EA2C4CEEB;
	Sun, 24 Aug 2025 07:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756018808;
	bh=hBFIZ04UzgQBlo5Sx1B81eWI+Zc3+ZZtAl2/5tzYiD8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=EosBavdTfQUbwcvttdEjkoX2oKjqQabTYSrYJqgd0Jcx3+KQl3KPTggbHpkZQ/SQ0
	 YO28V3E0FZsHyHLZUk53hqdA496fQGi4WFzOe5L4+EQkB6XOLNgr8R1u2x79ozS5N+
	 7TPO4xMm6nccVRkL1M/MZVturZvAFqb6JLoyz4wG87CHlO0wDuQqfUWjMqBiRg/Cb1
	 6KDPviBjAWSZsRwDzOaM/sY6bPq1POdypjc/3XOG4yCuCxGdKnFNPTdH1zm6E7pouZ
	 1GZ7IsSZrKJHptR/bioqU6rlFdLcasJAxlKoQAmGcGFBDajyzW397+VFt2sFJfHsPU
	 16YPWW4b793sA==
Message-ID: <c7e430c8-95aa-4ff2-b39f-f36783b97b06@kernel.org>
Date: Sun, 24 Aug 2025 09:00:04 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Modules fixes for v6.17-rc3
From: Daniel Gomez <da.gomez@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Thorsten Blum <thorsten.blum@linux.dev>,
 Kees Cook <kees@kernel.org>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250824064922.41894-1-da.gomez@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <20250824064922.41894-1-da.gomez@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 24/08/2025 08.49, Daniel Gomez wrote:
> This includes a fix as part of the KSPP (Kernel Self Protection Project) to
> replace the deprecated and unsafe strcpy() calls in the kernel parameter string
> handler and sysfs parameters for built-in modules. Single commit, no functional
> changes.

The fix was merged 1 week ago (August 16) and in linux-next since next-20250818.
