Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5C284D02;
	Fri, 15 Nov 2024 17:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731691647; cv=none; b=gqUc/yFxo5AJZntN3qkZZoqTqUh5wQwtLjjHoAcUfMUW5L7jBr4Iwea0jAxKQzjZwKQztVoQAWpsnz8F5BXW1wpetv9pglFNfb6LLwvowjBjjWQusRiUPwBnNZXRChYsu7tcd31gUa5VEnUOZ9ZDpSGqIqEqOq149RDBZpH+b3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731691647; c=relaxed/simple;
	bh=YCufd6lrdaAozuR5N6Mh8z6A/7Gb2wGA+G5IB+FuBDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R4yREIfmtgqX1IA6pF9N0bX8Rm8hEsNOWTQB5uSpPFbICG7Bp4kSvTr3Apap1qCRqqm9aMA6QpDi02ImYeLogRGLJdWCxN2F3gvpB7P+6CuFKHcaTpd7EpBPUGvS+cv9qDdEIPjQRVWStWI7He5qXvTSMwxdupWTCi0cH7HNOfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=AlhEc+Wr; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="AlhEc+Wr"
Received: from [192.168.42.96] (p5de457db.dip0.t-ipconnect.de [93.228.87.219])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id D6BA62FC0057;
	Fri, 15 Nov 2024 18:27:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1731691641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1yJ9wk6LIx5dW8HlLVRa6cUdg5kgKWI4Glgx81OCOQQ=;
	b=AlhEc+Wr8JjenunIwgBWl+XikhJAwbw1mm4EIeuJGjAvXwTb7zTgkiyObcrdHj+SKGyFur
	hAgpCgCk2lIo7LiWAHDe1rzNyO6mWvUwvyFJMrHeiINdqGqMkHS6fx26ourtePxbG9O1w8
	a1yrrNqzQDJhWGItc/0BoKoa6qC6yMU=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <4356a7f8-2c37-4d34-9e77-8af83d251cee@tuxedocomputers.com>
Date: Fri, 15 Nov 2024 18:27:20 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] module: Block some modules by TUXEDO from
 accessing
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: mcgrof@kernel.org, petr.pavlu@suse.com, samitolvanen@google.com,
 da.gomez@samsung.com, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@leemhuis.info, vv@tuxedocomputers.com,
 cs@tuxedo.de
References: <20241115130139.1244786-1-wse@tuxedocomputers.com>
 <3023bbda-0902-4e5c-aeb1-074623cd8ff0@tuxedocomputers.com>
 <uedhiz7luybtelifxooii5efesmpuot3bsoifdutsvt4axyror@zq37gl3x7je2>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <uedhiz7luybtelifxooii5efesmpuot3bsoifdutsvt4axyror@zq37gl3x7je2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

Am 15.11.24 um 17:40 schrieb Uwe Kleine-König:
> Hello Werner,
>
> On Fri, Nov 15, 2024 at 02:03:27PM +0100, Werner Sembach wrote:
>> Am 15.11.24 um 13:58 schrieb Werner Sembach:
>>> Following the meeting I wrote about yesterday, I now changed the license
>>> of what we could change spontaniously to prove good faith.
>>>
>>> I still hope that the rest can be sorted out before anything gets merged.
>>> We are working on it. A clear time window would still be helpfull.
>>>
>>> At Uwe. I don't know how it works if you modifiy someone elses code. I
>>> removed the Signed-off-by: line and I guess you have to add it again?
> The more usual thing would have been to reply to my mail saying
> something like:
>
> 	All the code in tuxedo-drivers.git that Tuxedo owns the complete
> 	copyright for was relicensed to GPLv2+ now. (See $link)
> 	For the remaining code I'm working in the background towards
> 	relicensing.
>
> 	So please drop
>
> 		$modulelist
>
> 	from your patch of modules to block.
>
> I'm sure with that feedback you don't risk that the original patch is
> applied.
After the prevailing discussion, I'm not so sure about this. I went with the 
safe option of sending code, because code usually gets more attention on the 
LKML in my experience.
>
> If you take someone else's patch and rework it (which IMHO should only
> be done when the original submitter dropped following up to prevent
> duplication of work), it's good style to explicitly mention the changes
> you implemented since the patch was initially posted. And then don't
> remove the S-o-b line. See 7602ffd1d5e8927fadd5187cb4aed2fdc9c47143 for
> an example. I think this is (at least partly) also described in
> Documentation/ somewhere.
Thanks for the reference, I will come back to it when I need it in the future.
>
> Looking at
> https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/commit/dd34594ab880ed477bb75725176c3fb9352a07eb
> (which would be $link mentioned above): If you switch to GPLv2, using
> the SPDX-License-Identifier should be good enough (but INAL). For sure
> don't put "51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA"
> in your files,
> https://www.fsf.org/blogs/community/fsf-office-closing-party. Just keep
>
> 	You should have received a copy of the GNU General Public License
> 	along with this program; if not, see <https://www.gnu.org/licenses/>.
>
> which is also the current suggestion by the FSF,
> https://www.gnu.org/licenses/old-licenses/gpl-2.0.html.
>
> Thanks for working on this!
> Uwe

TBH I would be more happy with an apology for being called a liar, as I was 
already working on it starting Monday.

Best regards,

Werner Sembach

