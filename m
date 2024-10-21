Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936561FDF85;
	Mon, 21 Oct 2024 20:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729542859; cv=none; b=kNAbho3L0jRftnUic9nKf/h/JqJOiaH8wG0Znwg8bJso32KEjsgdK8wyAzeAComXSBNiOiuGCi3M+sm0W/J2WuHzOj5EBt6xbU/Wo81sTzUM2W+hejkSCnoTBXPEIXpEo6QazIT7Wub1leE9+Hnlv78xXny6qIuaLVb/in3Ft3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729542859; c=relaxed/simple;
	bh=gGROye+ol9CC+OcvT+hiRxGXLruEirN4yuJSLxK8H7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpt35h3M0X32TIHndXM4DEIVhwF3rMpUciVr6hM7OvjDE3WPJg5VgtkHjOUm+lRm846tjUJyUfvrUvk5wJDsiN+KY15dqsnTqrc6Or0wNkYVIcu5R3y3JUZhPrgPkTXCL5q0AtvDr7sg25vfdY0O5emGrJ23HEOqxegnnZrTGi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYl8HpGz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYl8HpGz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BCAC4CEC3;
	Mon, 21 Oct 2024 20:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729542858;
	bh=gGROye+ol9CC+OcvT+hiRxGXLruEirN4yuJSLxK8H7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XYl8HpGzwgblkaLMC+CGcVzIQMJwAOrIRcGS3ymosoyWIayHP3wbdb6dNTiyOKFd2
	 EJdGd6NCPbT4OqgM0mpJd2kBU4lpB8DS0bls9NNASywZPqOM4cQHK/9iKTOKIJeNfF
	 8jqSGsEnSY2dEDJEgftIpC4KG1wm3PpenQDrHFz4bGEYtirKtmnintOGWIooREzlZ5
	 czzkcXN/QRBxbQcyFxlMw7qbCdrYa0qqqbE2NzNq4voZGux3QyfWl9TJgZonap9MjK
	 fGYLyqmXTso+XBOnh7CUv0xq+f1NEgrbUPFp/3prc1Q9ENtX2onylFxIOvtz5QrDnX
	 66gX7PlptK/7w==
Date: Mon, 21 Oct 2024 13:34:16 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Tobias Stoeckmann <tobias@stoeckmann.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: check symbol name offsets
Message-ID: <Zxa6yEN-ywx259WO@bombadil.infradead.org>
References: <2hhrajjoxixnkhtlhhqzjxki4iuhr362345wgrmg6uzbfhlupo@hgbjsb5wizir>
 <ZxaxtnuAMuuTgN2I@bombadil.infradead.org>
 <xq5kctkuanhzziv6cizkq5e3xgoxdnzzqft3wwu3kc7djgguem@l6kmhhd72lxr>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xq5kctkuanhzziv6cizkq5e3xgoxdnzzqft3wwu3kc7djgguem@l6kmhhd72lxr>

On Mon, Oct 21, 2024 at 10:20:38PM +0200, Tobias Stoeckmann wrote:
> Hi Luis,
> 
> On Mon, Oct 21, 2024 at 12:55:34PM -0700, Luis Chamberlain wrote:
> > And then you can make a series with 3 patches for this and your prior one,
> > and you can just refer to the PoC in the fix.
> 
> Thanks for the hint to rebase on modules-next. There is no need for my
> patches, because the checks have been written by Matthew Maurer, which
> cover these cases.
> 
> So... Sorry for the noise and thanks to Matthew for writing them.
> Clarifies that specs are correct and checks were missing. :)

It does not mean that older kernels have them. And selftests are used to
test older kernel, and so the question here is if a patch from Matthew
should be backported, and if so which one? So your PoC test is still welcome.

  Luis
