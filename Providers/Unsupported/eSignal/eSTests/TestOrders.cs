#region Copyright
/*
 * Software: TickZoom Trading Platform
 * Copyright 2009 M. Wayne Walter
 * 
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * Business use restricted to 30 days except as otherwise stated in
 * in your Service Level Agreement (SLA).
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see <http://www.tickzoom.org/wiki/Licenses>
 * or write to Free Software Foundation, Inc., 51 Franklin Street,
 * Fifth Floor, Boston, MA  02110-1301, USA.
 * 
 */
#endregion

using System;
using System.Diagnostics;
using System.IO;
using System.Reflection;
using System.Threading;

using NUnit.Framework;
using TickZoom.Api;
using TickZoom.eSignal;

namespace TickZoom.Test
{
	[TestFixture]
	public class TestOrders
	{
		private static readonly Log log = Factory.Log.GetLogger(typeof(TestOrders));
		private static readonly bool debug = log.IsDebugEnabled;		
		private Provider provider;
		protected SymbolInfo symbol;
		protected VerifyFeed verify;
		private bool localFlag = true;
			
		[TestFixtureSetUp]
		public virtual void Init()
		{
			string appData = Factory.Settings["AppDataFolder"];
			File.Delete( appData + @"\Logs\eSignalProviderTests.log");
			File.Delete( appData + @"\Logs\eSignalProviderService.log");
	  		symbol = Factory.Symbol.LookupSymbol("GC");
		}
		
		[TestFixtureTearDown]
		public void Dispose()
		{
		}
		
		public void CreateProvider() {
			if( localFlag) {
				provider = new eSInterface();
			} else {
				provider = Factory.Provider.ProviderProcess("127.0.0.1",6492,"eSignalProviderService.exe");
			}
			verify = new VerifyFeed();
			provider.Start(verify);
		}
		
		[SetUp]
		public void Setup() {
			CreateProvider();
		}
		
		[TearDown]
		public void TearDown() { 
	  			provider.Stop(verify);	
		}
		
		[Test]
		public void TestSingleOrder() {
			if(debug) log.Debug("===DemoConnectionTest===");
  			provider.StartSymbol(verify,symbol,TimeStamp.MinValue);
  			provider.PositionChange(verify,symbol,150,null);
  			long count = verify.Verify(2,AssertTick,symbol,25);
  			Assert.GreaterOrEqual(count,2,"tick count");
  			Thread.Sleep(500);
  			provider.PositionChange(verify,symbol,0,null);
  			count = verify.Verify(2,AssertTick,symbol,25);
  			Assert.GreaterOrEqual(count,2,"tick count");
  			Thread.Sleep(500);
  			provider.PositionChange(verify,symbol,100,null);
  			count = verify.Verify(2,AssertTick,symbol,25);
  			Assert.GreaterOrEqual(count,2,"tick count");
  			Thread.Sleep(500);
  			provider.PositionChange(verify,symbol,0,null);
  			count = verify.Verify(2,AssertTick,symbol,25);
  			Assert.GreaterOrEqual(count,2,"tick count");
		}
		
		public virtual void AssertTick( TickIO tick, TickIO lastTick, ulong symbol) {
        	Assert.IsFalse(tick.IsQuote);
        	if( tick.IsQuote) {
	        	Assert.Greater(tick.Bid,0);
	        	Assert.Greater(tick.BidLevel(0),0);
	        	Assert.Greater(tick.Ask,0);
	        	Assert.Greater(tick.AskLevel(0),0);
        	}
        	Assert.IsTrue(tick.IsTrade);
        	if( tick.IsTrade) {
	        	Assert.Greater(tick.Price,0);
    	    	Assert.Greater(tick.Size,0);
        	}
    		Assert.IsTrue(tick.Time>=lastTick.Time,"tick.Time > lastTick.Time");
    		Assert.AreEqual(symbol,tick.lSymbol);
		}
	}
}
