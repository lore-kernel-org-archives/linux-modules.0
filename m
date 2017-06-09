Return-Path: <joel.stan@gmail.com>
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <CAKi4VALeXAYkSRVOUL8qfCk4zaniv3Ncxk=Pb2YoqKK3TtPEvA@mail.gmail.com>
References: <20170607061811.4016-1-joel@jms.id.au> <CACPK8XcLBdLijc-CfxoFRNq6pHX6nGri7JCTyfJS9qx+8Juv=Q@mail.gmail.com>
 <CAKi4VALeXAYkSRVOUL8qfCk4zaniv3Ncxk=Pb2YoqKK3TtPEvA@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 9 Jun 2017 14:40:45 +0930
Message-ID: <CACPK8Xd35t9GhwX3bHtJMRFz5zz8T-iWDDL_OpwnXij_ns45rQ@mail.gmail.com>
Subject: Re: [PATCH kmod] util: fix non-static assert_cc use
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>,
	Stewart Smith <stewart@linux.vnet.ibm.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-modules.vger.kernel.org>

On Fri, Jun 9, 2017 at 8:38 AM, Lucas De Marchi
<lucas.de.marchi@gmail.com> wrote:
> On Wed, Jun 7, 2017 at 5:00 AM, Joel Stanley <joel@jms.id.au> wrote:
>> On Wed, Jun 7, 2017 at 3:48 PM, Joel Stanley <joel@jms.id.au> wrote:
>>> In commit a6ede6c7ad46 (util: fix warning of equal values on logical OR)
>>> the runtime check for EAGAIN and EWOULDBLOCK being equal was converted
>>> into an assert.
>>>
>>> For the case where the compiler supports _Static_assert, this is can be
>>> called staticly. However the fallback for older compilers uses a
>>> non-static test that needs to be called from a function context.
>>>
>>> Move the assert into the functions that used to have the runtime check.
>>> The test does not add any runtime overhead, so it is fine to duplicate
>>> it.
>>>
>>> Tested with and without HAVE_STATIC_ASSERT defined using GCC 6.3.
>>>
>>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>>
>> I just saw the git history and noticed that Thomas sent a patch fixing
>> this already. Excellent! Sorry for the noise.
>
> So many people using ancient compilers... I must be missing the fun :)

Yeah. Supporting groups that insist on using RHEL6.4 and gcc 4.4 is a
barrel of laughs.

:)

Cheers,

Joel
