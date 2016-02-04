Return-Path: <mmarek@suse.cz>
Subject: Re: Support for PKCS#7 module signing.
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
References: <CAC0jrpN5e3bmS0EO+poA7cx0eLjH59BkWwAFuOmDX-qE6WGs-w@mail.gmail.com>
 <CAKi4VA+ZsmP_xfQgD9XpoXidB=-JaMcpsAfG7v4-M2my3khVkg@mail.gmail.com>
Cc: Wouter van Kesteren <woutershep@gmail.com>,
 linux-modules <linux-modules@vger.kernel.org>,
 David Howells <dhowells@redhat.com>
From: Michal Marek <mmarek@suse.cz>
Message-ID: <56B34FF1.30305@suse.cz>
Date: Thu, 4 Feb 2016 14:19:45 +0100
MIME-Version: 1.0
In-Reply-To: <CAKi4VA+ZsmP_xfQgD9XpoXidB=-JaMcpsAfG7v4-M2my3khVkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-modules.vger.kernel.org>

On 2016-01-14 20:43, Lucas De Marchi wrote:
> Hi Wouter,
> 
> 
> Sorry for the delay.

Hi,

sorry for the even longer delay.


> On Sun, Jan 10, 2016 at 10:15 PM, Wouter van Kesteren
> <woutershep@gmail.com> wrote:
>> Hello,
>>
>> I asked the following on irc, where it was suggested that i take it to
>> this mailing list instead.
>>
>> Commit https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=bc1c373dd2a5113800360f7152be729c9da996cc
>> introduced a new method of signing modules.
>>
>> I attempted to make a patch to support this new method of signing. But
>> whilst doing so i came to the conclusion that a lot of things that are
>> in the appended struct are now set to zero.
>> Infact, everything except id_type (which is 2) and sig_len is set to
>> zero. Instead this information seems to be embedded in the signature
>> blob instead.
> 
> That struct should be filled by the tool signing the module:
[...]
> I'm not sure why it was decided to omit this information in the commit
> you mentioned and embed it inside the signature blob.

The kernel now retrieves the hash and algorithm from the PKCS#7 message.

> Ideally kmod would not link to any crypto library.

Right. What we can do easily is to print signature: PKCS#7 to at least
let the user know that the module has a signature appended.

Michal
