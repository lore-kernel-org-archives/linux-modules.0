Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE8B173;
	Sat, 19 Oct 2024 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729350533; cv=none; b=iV9qXTHUvP2lhhk562PrrGe7nLxTXddXdcllbGanGgqs26CdaiOTVIJ5KquGdspw27CEcCle8iEATu0xCsyCetkYF8st6vahEypVLuMPUn61ibUdJ57Y7E98MwhFz+cgIVC6Eg+WhRRFMvFfgON5N/UOGRv4KokZmDA3qU7dQ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729350533; c=relaxed/simple;
	bh=INBbBIlLs/UrNavyh1+opMYimFV6zgGy/6n+UeZOc3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiOFyL/5lssKYiNd4MPss8iIIZr280ie44HrrK6kLwPcQD3QXLfMZVpIZw4GtcLnrCa00LSpFp5KV4QEG9QRYjqWkGtgtxzglmf24Spq5RzVzarGQ6nYqFH2SS/sF7eTTuT0fctbq7x49FhOmdEyWMoUKtbFXLlt9gD56ATXZfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stoeckmann.org; spf=pass smtp.mailfrom=stoeckmann.org; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stoeckmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stoeckmann.org
Received: from localhost ([93.225.54.107]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis) id
 1Md6ZB-1taPTk3uyp-00clms; Sat, 19 Oct 2024 17:07:56 +0200
Date: Sat, 19 Oct 2024 17:07:53 +0200
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: mcgrof@kernel.org
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: check symbol name offsets
Message-ID: <nnleg2smcmp2x57bwgt5rgty445up4yrzybgrhwtfscxstrkrs@qujmpvuotgjb>
References: <2hhrajjoxixnkhtlhhqzjxki4iuhr362345wgrmg6uzbfhlupo@hgbjsb5wizir>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2hhrajjoxixnkhtlhhqzjxki4iuhr362345wgrmg6uzbfhlupo@hgbjsb5wizir>
X-Provags-ID: V03:K1:rau0UUGU44g6KWu5N2S9A/ZpMC/NdEZEytoT3IlxDTqLNj1cc3S
 sqD0HpdvFplq9+9BoRzP7suz2FHC1+7hh5fvamUZ5JHUv0xLIcbwu8Gkv4tJszHhxLkWqpn
 qu4QJ0rCbJX+xrj2dBEkCm43YdXrwwxhCkIhByhNGr4Qnj7Ru3DgUGWU8/w5Hw0zQ56IP3E
 rkXYZhhe6dXKvbKNwN0/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SBsBRdvZB58=;eJa5AV4wYgXg3NNR6bJBxIoTr1t
 46DES3iIK1/O+UE4s/aP8NPsTYzEJkTMSSYeZh6vA0ed2rEWbNV94OC7tlBttOVvdG945BJ5+
 uIXOEf4sr9V3i2QBkctFeaifhgOO1MVCX8MdeI3zCAs+iyyZOR6ocULKcGpWny217NPBIZBJz
 30kQvYWxzPyvqAbnp+ZCF8pEX3gOK7RN8vUxLpNn/t+6hUxhoM8BO2Lp0gDCvisjyjsqJxmxx
 lGbo28h65KF7rGe0lNTwYxK/Z5pfr+76IL/AGLfDSowkJTTYF7wDVzyxaoQ4nBXQJtzIBXlRc
 jDcfeU1Cb9rGk4PLji8v/diZkllHmHmsJ3gzaOFCvDC2MnPErq8lYzRrKeCipp5heIbavBfDh
 PpGnRcwlBC5kdjwH1bfIcYrmkvT6iSDfQgdBte6ZvyU2aQqApwGm8EMW0ScbOqgUhSSrAPKC0
 0oiVraV5FA9cD2d6VesAW3B+cHCw6ZQAoRt0JFLQ26J4rdW3E38aKBxafx1Dl5rVjWiJooJ0o
 nA4UTY0KwrSWMB6iXj9NzVU2i0J/HKa7uVRK+4OEJwpIsGFGmfFfwSIIPOLoMto0llZC2bJX2
 5XnspdEByU6qEDmI8pS6Cq0kNgNjZQA3rmShsnAWkt1M7rntr7ZTVFRosNkB2jcnRgxjw1SxL
 2Xo0AOmud71ivhs+qXm7G8lRz33ryMc17J8FREtyaC5UartKjMgttYOtlErugAndbsQ5hbalp
 Om1TaXXPlAbnIRNZhgN/r8vCrufeYsU5w==

On Sat, Oct 19, 2024 at 04:15:33PM +0200, Tobias Stoeckmann wrote:
> +		if (sym[i].st_name >= strhdr->sh_size) {

Please note that this commit only makes sense being applied AFTER
the other patch sent, i.e. "module: .strtab must be null terminated"
because that patch modifies strhdr before this line.

Sorry for messing up the PATCH 1/2 and 2/2 connection.


With kind regards

Tobias
